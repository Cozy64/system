{ ...}:
{
  services = {
   #nextjs-ollama-llm-ui = {
   #  enable = true;

   #};

    ollama = {
      enable = true;
      rocmOverrideGfx = "10.30.0";

    };
  };

}
