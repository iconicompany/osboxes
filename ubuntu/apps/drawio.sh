set -e
cd /tmp
curl -fsSL https://api.github.com/repos/jgraph/drawio-desktop/releases/latest -o /tmp/drawio-release.json
DEB_URL=$(jq -r '.assets[] | select(.name | test("^drawio-amd64-.*\\.deb$")) | .browser_download_url' /tmp/drawio-release.json | head -n 1)

if [ -z "$DEB_URL" ] || [ "$DEB_URL" = "null" ]; then
  echo "No amd64 .deb asset found in the latest draw.io release."
  exit 1
fi

printf '%s\n' "$DEB_URL"

curl -fL -o drawio-amd64.deb "$DEB_URL"
sudo apt install ./drawio-amd64.deb -y