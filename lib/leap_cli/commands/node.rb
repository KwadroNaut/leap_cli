require 'net/ssh/known_hosts'
require 'tempfile'

module LeapCli; module Commands

  ##
  ## COMMANDS
  ##

  desc 'not yet implemented... Create a new configuration for a node'
  command :'new-node' do |c|
    c.action do |global_options,options,args|
    end
  end

  desc 'Bootstraps a node, setting up ssh keys and installing prerequisites'
  arg_name '<node-name>', :optional => false, :multiple => false
  command :'init-node' do |c|
    c.action do |global_options,options,args|
      node = get_node_from_args(args)
      ping_node(node)
      save_public_host_key(node)
      update_compiled_ssh_configs
      ssh_connect(node, :bootstrap => true) do |ssh|
        ssh.install_authorized_keys
        ssh.install_prerequisites
      end
    end
  end

  desc 'not yet implemented'
  command :'rename-node' do |c|
    c.action do |global_options,options,args|
    end
  end

  desc 'not yet implemented'
  arg_name '<node-name>', :optional => false, :multiple => false
  command :'rm-node' do |c|
    c.action do |global_options,options,args|
      remove_file!()
    end
  end

  ##
  ## PUBLIC HELPERS
  ##

  #
  # generates the known_hosts file.
  #
  # we do a 'late' binding on the hostnames and ip part of the ssh pub key record in order to allow
  # for the possibility that the hostnames or ip has changed in the node configuration.
  #
  def update_known_hosts
    buffer = StringIO.new
    manager.nodes.values.each do |node|
      hostnames = [node.name, node.domain.internal, node.domain.full, node.ip_address].join(',')
      pub_key = read_file([:node_ssh_pub_key,node.name])
      if pub_key
        buffer << [hostnames, pub_key].join(' ')
      end
    end
    write_file!(:known_hosts, buffer.string)
  end

  def get_node_from_args(args)
    node_name = args.first
    node = manager.node(node_name)
    assert!(node, "Node '#{node_name}' not found.")
    node
  end

  private

  ##
  ## PRIVATE HELPERS
  ##

  #
  # saves the public ssh host key for node into the provider directory.
  #
  # see `man sshd` for the format of known_hosts
  #
  def save_public_host_key(node)
    progress("Fetching public SSH host key for #{node.name}")
    public_key = get_public_key_for_ip(node.ip_address)
    pub_key_path = Path.named_path([:node_ssh_pub_key, node.name])
    if Path.exists?(pub_key_path)
      if public_key == SshKey.load_from_file(pub_key_path)
        progress("Public SSH host key for #{node.name} has not changed")
      else
        bail!("WARNING: The public SSH host key we just fetched for #{node.name} doesn't match what we have saved previously. Remove the file #{pub_key_path} if you really want to change it.")
      end
    elsif public_key.in_known_hosts?(node.name, node.ip_address, node.domain.name)
      progress("Public SSH host key for #{node.name} is trusted (key found in your ~/.ssh/known_hosts)")
    else
      puts
      say("This is the SSH host key you got back from node \"#{node.name}\"")
      say("Type        -- #{public_key.bits} bit #{public_key.type.upcase}")
      say("Fingerprint -- " + public_key.fingerprint)
      say("Public Key  -- " + public_key.key)
      if !agree("Is this correct? ")
        bail!
      else
        puts
        write_file!([:node_ssh_pub_key, node.name], public_key.to_s)
      end
    end
  end

  def get_public_key_for_ip(address)
    assert_bin!('ssh-keyscan')
    output = assert_run! "ssh-keyscan -t rsa #{address}", "Could not get the public host key. Maybe sshd is not running?"
    line = output.split("\n").grep(/^[^#]/).first
    assert! line, "Got zero host keys back!"
    ip, key_type, public_key = line.split(' ')
    return SshKey.load(public_key, key_type)
  end

  def ping_node(node)
    progress("Pinging #{node.name}")
    assert_run!("ping -W 1 -c 1 #{node.ip_address}", "Could not ping #{node.name} (address #{node.ip_address}). Try again, we only send a single ping.")
  end

end; end