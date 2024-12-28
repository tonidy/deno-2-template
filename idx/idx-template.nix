{ version ? "v2.1.4"
, ...
}: {

  packages = [ ];

  bootstrap = ''
    			mkdir "$out"
    			npx create-next-app@${version} "$out" \
					  --yes \
					  --skip-install \
    				--import-alias=${importAlias} \
    				--${language} \
    				--use-${packageManager} \
    				${if eslint then "--eslint" else "--no-eslint"} \
    				${if srcDir then "--src-dir" else "--no-src-dir"} \
    				${if app then "--app" else "--no-app"} \
    				${if tailwind then "--tailwind" else "--no-tailwind"}

    			mkdir -p "$out"/.idx
      		cp ${./dev.nix} "$out"/.idx/dev.nix
    			chmod -R +w "$out"

    			${
         if packageManager == "npm" then
           "( cd $out && npm i --package-lock-only --ignore-scripts )"
         else
           ""
       }
  '';
}