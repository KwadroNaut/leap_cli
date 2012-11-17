# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "certificate_authority"
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chris Chandler"]
  s.date = "2012-09-16"
  s.email = "chris@flatterline.com"
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "Gemfile",
    "Gemfile.lock",
    "README.rdoc",
    "Rakefile",
    "VERSION.yml",
    "certificate_authority.gemspec",
    "lib/certificate_authority.rb",
    "lib/certificate_authority/certificate.rb",
    "lib/certificate_authority/certificate_revocation_list.rb",
    "lib/certificate_authority/distinguished_name.rb",
    "lib/certificate_authority/extensions.rb",
    "lib/certificate_authority/key_material.rb",
    "lib/certificate_authority/ocsp_handler.rb",
    "lib/certificate_authority/pkcs11_key_material.rb",
    "lib/certificate_authority/revocable.rb",
    "lib/certificate_authority/serial_number.rb",
    "lib/certificate_authority/signing_entity.rb",
    "lib/certificate_authority/signing_request.rb",
    "lib/tasks/certificate_authority.rake",
    "spec/samples/certs/DigiCertHighAssuranceEVCA-1.pem",
    "spec/samples/certs/apple_wwdr_issued_cert.pem",
    "spec/samples/certs/apple_wwdr_issuer.pem",
    "spec/samples/certs/ca.crt",
    "spec/samples/certs/ca.key",
    "spec/samples/certs/client.crt",
    "spec/samples/certs/client.csr",
    "spec/samples/certs/client.key",
    "spec/samples/certs/github.com.pem",
    "spec/samples/certs/server.crt",
    "spec/samples/certs/server.csr",
    "spec/samples/certs/server.key",
    "spec/spec_helper.rb",
    "spec/units/certificate_authority_spec.rb",
    "spec/units/certificate_revocation_list_spec.rb",
    "spec/units/certificate_spec.rb",
    "spec/units/distinguished_name_spec.rb",
    "spec/units/extensions_spec.rb",
    "spec/units/key_material_spec.rb",
    "spec/units/ocsp_handler_spec.rb",
    "spec/units/pkcs11_key_material_spec.rb",
    "spec/units/serial_number_spec.rb",
    "spec/units/signing_entity_spec.rb",
    "spec/units/signing_request_spec.rb",
    "spec/units/units_helper.rb",
    "spec/units/working_with_openssl_spec.rb"
  ]
  s.homepage = "http://github.com/cchandler/certificate_authority"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.15"
  s.summary = "Ruby gem for managing the core functions outlined in RFC-3280 for PKI"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activemodel>, [">= 3.0.6"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 1.5.2"])
    else
      s.add_dependency(%q<activemodel>, [">= 3.0.6"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 1.5.2"])
    end
  else
    s.add_dependency(%q<activemodel>, [">= 3.0.6"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 1.5.2"])
  end
end
