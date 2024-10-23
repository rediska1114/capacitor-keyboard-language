package com.rediska1114.keyboardlanguage;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

@CapacitorPlugin(name = "KeyboardLanguage")
public class KeyboardLanguagePlugin extends Plugin {

  
    private String currentLanguage = null;
    private InputMethodManager inputMethodManager;
    private Handler handler;


    @Override
    public void load() {
        inputMethodManager = (InputMethodManager) getContext().getSystemService(Context.INPUT_METHOD_SERVICE);
        handler = new Handler();
        
        // Set an initial language when the plugin loads
        currentLanguage = getCurrentKeyboardLanguageInternal();
    }

    @PluginMethod
    public void getCurrentKeyboardLanguage(PluginCall call) {
        String language = getCurrentKeyboardLanguageInternal();
        call.resolve(createResult(language));
    }

    private String getCurrentKeyboardLanguageInternal() {
        InputMethodSubtype ims = inputMethodManager.getCurrentInputMethodSubtype();
        if (ims != null) {
            return ims.getLocale();  // Locale of the current keyboard
        }
        return null;
    }

    // Triggered when keyboard language changes
    private void notifyLanguageChange(String newLanguage) {
        JSObject ret = new JSObject();
        ret.put("language", newLanguage);
        notifyListeners("keyboardLanguageChange", ret);
    }

    // Optionally, you can poll for language changes if needed, similar to iOS polling
    private void startPollingForLanguageChanges() {
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                String newLanguage = getCurrentKeyboardLanguageInternal();
                if (newLanguage != null && !newLanguage.equals(currentLanguage)) {
                    currentLanguage = newLanguage;
                    notifyLanguageChange(currentLanguage);
                }
                handler.postDelayed(this, 1000);  // Poll every second
            }
        }, 1000);
    }

    @Override
    protected void handleOnStop() {
        handler.removeCallbacksAndMessages(null);  // Stop polling when the plugin is stopped
        super.handleOnStop();
    }

    @Override
    protected void handleOnResume() {
        startPollingForLanguageChanges();  // Start polling when the app is resumed
        super.handleOnResume();
    }

    private JSObject createResult(String language) {
        JSObject ret = new JSObject();
        ret.put("language", language);
        return ret;
    }
}
