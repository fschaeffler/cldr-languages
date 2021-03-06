cdlr-languages
==============
Status
------
https://travis-ci.org/fschaeffler/cldr-languages
[![Build Status](https://secure.travis-ci.org/fschaeffler/cldr-languages.png)](http://travis-ci.org/fschaeffler/cldr-languages)

Installation
------------
gem install cldr-languages

Usage
-----
    require 'cldr'
    require 'languages'
    include Cldr
    include Languages

    # imports all available languages to the folder config/locales
    import

    # retrieves a list of available language codes
    language_codes

    # retrieves a hash of available language codes and language names in English
    localized_languages

    # retrieves a hash of available language codes and language name in German with fallback English
    localized_languages(language: 'de')

    # retrieves a hash of available language codes and language name in German with fallback French
    localized_languages(language: 'de', :fallback 'fr')


    # please be aware that a call with 'zxx' as language parameter is very expensive. perhaps it's better to import
    # this localization and use the cached version.

    # retrieves a hash of available language codes and language name localized to the language code with fallback English
    localized_languages(language: 'zxx')

    # retrieves a hash of available language codes and language name localized to the language code with fallback German
    localized_languages(language: 'zxx', fallback: 'de')