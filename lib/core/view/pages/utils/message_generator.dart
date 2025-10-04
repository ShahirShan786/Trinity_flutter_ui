class MessageGenerator {
  static const Map<String, Map<String, String>> _messageMap = {
    "en": {
      "un-expected-error": "Some un expected error happened!",
      "un-expected-error-message": "Some un expected error happened!",
      "auth-welcome": "Input your credentials here to log in to the system.",
      "category_title" : "What would you like to do today?",
      "top_picks" : "Top picks for you",
      "craze_title": "Customer favourite\ntop supermarkets",
      "refer_message": "Invite your friends & earn 15% off",
    }
  };

  static const Map<String, Map<String, String>> _labelMap = {
    "en": {
      "OK": "OK",
      "Email" : "Email",
      "Password" : "Password",
      "Login" : "Login",
      "Account_havent" : "Don't have an account?",
      "Account_have" :"Already have an account?",
      "Signup" : "Sign Up",
      "Refer" : "Refer & Earn",
      "view" : "View all Stores"
      
    }
  };

  static String getMessage(String message) {
    return (_messageMap[getLanguage()] ?? {})[message] ?? message;
  }

  static String getLabel(String label) {
    return (_labelMap[getLanguage()] ?? {})[label] ?? label;
  }

  static String getLanguage() {
    // Implement multi language support here
    return "en";
  }
}