{ pkgs
, version ? "v2.1.4"
, ...
}: {

  packages = [ pkgs.curl pkgs.unzip ];

  bootstrap = ''
        # Install Deno
        curl -fsSL https://deno.land/install.sh | sh -s v2.1.4 -- --yes

    	mkdir "$out"
        mkdir -p "$out"/.idx

        echo ${version} > "$out/version.txt"

        cp -rf ${./dev.nix} "$out/.idx/dev.nix"
        shopt -s dotglob; cp -r ${../src}/* "$out"
        chmod -R +w "$out"
  '';

}
