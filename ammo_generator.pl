#/usr/bin/perl

use strict;
use warnings;
use Getopt::Std;

sub usage {
  print <<"__USAGE__";
Ammo generator for yandex-tank v.1
  Usage: ammo_generator.pl -u url -[cmr]
     -u: url (like http://host/uri)
     -c: cookies
     -m: method (GET, POST)
     -r: run yandex-tank againt created ammo file

__USAGE__
}

my $opts = {};
getopts('rhu:c:m:', $opts);

if ($opts->{h}) {
  usage();
  exit(0);
}

my $url = $opts->{u};
my $cookie = $opts->{c} || "";
my $method = $opts->{m} || "GET";

unless ($url) {
  usage();
  die "url not set (-u flag)\n";
}

$url =~ s|^https*://||;
unless ($url =~ m|^([^/]+)(/.*)$|) {
  die "url ($url) does not match pattern m|^([^/]+)/(.*)$|\n";
}

my $host = $1;
my $uri = $2;

$host =~ s/\r|\n//g;
$uri =~ s/\r|\n//g;
$cookie =~ s/\r|\n//g;

my $req= "$method $uri HTTP/1.1\r\n".
  "User-Agent: YandexTank/1.1.1\r\n".
  "Host: $host\r\n".
  "Accept-Encoding: gzip, deflate\r\n".
  "Cookie: $cookie\r\n".
  "Connection: Close\r\n".
  "\r\n";

my $target = "ammo_${host}${uri}.txt";
$target =~ s(/|:)(_)g;

open(F, ">", $target) or die "Unable to create file $!";
print F length($req)."\n".$req;
close(F);

print "writed:\n\t$target\n";
print "curl:\n\t";

my $curlPost = $method eq 'POST' ? '-d ""' : '';

print <<"__CURL__";
curl $curlPost -H "User-Agent: YandexTank/1.1.1" -H "Host: $host" -H "Accept-Encoding: gzip, deflate" -H "Cookie: $cookie" -H "Connection: Close" "${host}${uri}"
__CURL__

if ($opts->{r}) {
  print "Running yandex-tank against $target\n";
  system("yandex-tank \"$target\"");
}
