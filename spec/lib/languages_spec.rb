# encoding: utf-8
require 'spec_helper'

describe ModuleClass do

  it "return all language codes without self localization" do
    all_language_codes = language_codes

    all_language_codes.should include('en')
    all_language_codes.should include('fr')
    all_language_codes.should include('de')
    all_language_codes.should include('af')

    all_language_codes.should_not include('zxx')
  end

  it "return all language codes with self localization" do
    all_language_codes = language_codes(true)

    all_language_codes.should include('en')
    all_language_codes.should include('fr')
    all_language_codes.should include('de')
    all_language_codes.should include('af')

    all_language_codes.should include('zxx')
  end

  it "return a set of localized languages" do
    all_localized_languages = localized_languages(language: 'de')

    all_localized_languages.should_not be_nil
    all_localized_languages['de'].should == 'Deutsch'
    all_localized_languages['en'].should == 'Englisch'
    all_localized_languages['fr'].should == 'Französisch'
  end

  it "return a set of self localized languages" do
    all_localized_languages = localized_languages(language: 'zxx')

    all_localized_languages['de'].should == 'Deutsch'
    all_localized_languages['en'].should == 'English'
    all_localized_languages['uk'].should == 'українська'
    all_localized_languages['ta'].should == 'தமிழ்'
  end

  it "import all languages" do
    all_localized_languages = localized_languages

    no_of_cached_files = 0

    dir = Dir.mktmpdir
    begin
      import(root_folder: (dir + '/'))
      no_of_cached_files = Dir[File.join(dir + '/config/locales/', '**', '*')].count { |file| File.file?(file) }
    ensure
      FileUtils.remove_entry dir
    end

    all_localized_languages.length.should == no_of_cached_files
  end
end

