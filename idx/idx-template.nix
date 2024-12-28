{ pkgs
, version ? "v2.1.4"
, ...
}: {

  packages = [ pkgs.curl pkgs.unzip ];

  bootstrap = ''
      # Install Deno
      # curl -fsSL https://deno.land/install.sh | sh -s ${version} -- --yes

      mkdir "$out"
      cd "$out"

      mkdir -p .idx/
      mkdir -p .vscode/

      echo ${version} > version.txt

      cp -f ${./dev.nix} ".idx/dev.nix"
      # cp -f ${./settings.json} ".vscode/settings.json"

      cd ..
      shopt -s dotglob; cp -r ${../src}/* "$out"
      chmod -R +w "$out"
  '';

}
