
{
  time.timeZone = "Europe/Berlin";
  
  i18n = {
    defaultLocale = "en_US.UTF-8";
    
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"
    ];
    
    # Force EVERYTHING to known locales
    extraLocaleSettings = {
      LC_CTYPE = "en_US.UTF-8";        # Character classification
      LC_NUMERIC = "de_DE.UTF-8";      # Number formatting
      LC_TIME = "de_DE.UTF-8";         # Time/date formatting
      LC_COLLATE = "en_US.UTF-8";      # String sorting
      LC_MONETARY = "de_DE.UTF-8";     # Money formatting
      LC_MESSAGES = "en_US.UTF-8";     # System messages
      LC_PAPER = "de_DE.UTF-8";        # Paper size
      LC_NAME = "de_DE.UTF-8";         # Name formatting
      LC_ADDRESS = "de_DE.UTF-8";      # Address formatting
      LC_TELEPHONE = "de_DE.UTF-8";    # Phone number formatting
      LC_MEASUREMENT = "de_DE.UTF-8";  # Measurement units
      LC_IDENTIFICATION = "de_DE.UTF-8"; # Locale identification
    };
  };

  # Override any stray locale settings
  environment.variables = {
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
  };
}
