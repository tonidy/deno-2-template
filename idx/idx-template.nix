{ version ? "v2.1.4"
, ...
}: {

  packages = [ ];

  bootstrap = ''
        # Install Deno
        curl -fsSL https://deno.land/install.sh | sh -s $version

    	  mkdir "$out"
        mkdir -p "$out"/.idx

        cp -rf ${./dev.nix} "$out/.idx/dev.nix"
        shopt -s dotglob; cp -r ${../src}/* "$out"
        chmod -R +w "$out"
  '';

}
