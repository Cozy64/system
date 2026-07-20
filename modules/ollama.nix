{pkgs, ...}:
{
  services = {
   #nextjs-ollama-llm-ui = {
   #  enable = true;

   #};

    ollama = {
      enable = true;
      #rocmOverrideGfx = "10.30.0";
      package = pkgs.ollama-vulkan;
      environmentVariables = {
        OLLAMA_IGPU_ENABLE = "1";
    };


    };
  };

}
