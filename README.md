# logfile-generators

## Running the scripts
 - $ chmod u+x script_name
 - $ ./script-name

## Sample output
 - $ ./http-traffic-gen.sh
 - 39.124.8.221 salt - [26/Jul/2014:18:47:49 -0400] "POST /example/path/index.php HTTP/1.1" 200 8247 "http://yahoo.com/example/path/index.php" "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.134 Safari/537.36 Chrome 43.0 Win7 64-bit"
 -  39.151.3.98 - - [26/Jul/2014:18:48:14 -0400] "HEAD /index.html HTTP/1.1" 404 21032 "http://yahoo.com/index.html" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.130 Safari/537.36 Chrome 43.0 MacOSX"

## TODO
  - Correct script names
  - Add more content to arrays
  - Fix formatting
  - Add syslog example file for use with the syslog generation script

## Acknowledgements/Contributors
  - Special thanks to Justin Wray (Synister Syntax)
