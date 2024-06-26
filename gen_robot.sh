#!/bin/bash
HOST=${1:-"mirror.nyist.edu.cn"}

echo "# robots.txt for https://$HOST" > robots.txt
echo 'User-agent: *' >> robots.txt
echo '' >> robots.txt
echo 'Disallow: /logs' >> robots.txt

(
  curl -s https://$HOST/static/tunasync.json | jq -r '.[] | .name'
  echo "lede";
  echo "raspberry-pi-os";
  echo "ctan";
  echo "cygwin";
  echo "pub";
  echo "git";
) | uniq | while read name; do
	[[ -z ${name} ]] || [[ ${name} = "tuna" ]] && continue
	echo "Disallow: /${name}" >> robots.txt
done
