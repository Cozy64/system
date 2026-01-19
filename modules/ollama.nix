{ ...}:
{
  services = {
   nextjs-ollama-llm-ui = {
     enable = true;

   };

    ollama = {
      enable = true;
      #rocmOverrideGfx = "";

    };
  };

}
