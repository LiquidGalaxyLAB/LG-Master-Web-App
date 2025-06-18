// ---------API INFORMATION---------
const String apiKey = 'YOUR_ACTUAL_API_KEY';
// Getting an API key depends on the model you are using
// FOR GEMINI:
     // Sign in to your Google account
     // Go to Google AI Studio
     // Look for the 'Gemini API' tab or a button that says 'Get API key in Google AI Studio'
     // Click 'Get API Key' or 'Create API Key'
     // Review and accept the terms of service
     // Copy your API key. DO NOT SHARE IT OR COPY IT INTO PUBLIC CODE REPOSITORIES!!!

// FOR CHATGPT:
     // Sign in to your OpenAI account (or create one)
     // Click on your profile or the left navigation menu and find 'API Keys' or 'View API keys'
     // Click 'Create new secret key', give it a name, and generate the key
     // Copy and store your API key securely. You’ll only see this key once, so save it in a secure place and never share it publicly
     // OpenAI API is not free, so you need to add billing info to use the API for production or extended use

// ---------MODEL INFORMATION---------
// This is for Gemini and ChatGPT because they are the models used as an example in the lg_ai.dart file
// Replace with your model information if it is not one of these two

// Google Gemini
const String geminiApiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';
// Remember that for Gemini, ?key=$apiKey is appended when making the request, NOT in the config variable itself
// This keeps the configuration reusable

// ChatGPT
const String chatgptApiUrl = 'https://api.openai.com/v1/chat/completions';
// Remember that for ChatGPT the API key is sent in the header, NOT in the URL
