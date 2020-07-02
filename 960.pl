use strict;
use warnings;
use List::Util qw(shuffle);
use Data::Dumper;

my @p = qw(b b k n n q r r);
my %pos;
my $tries = 0;

while (keys %pos < 960) {
    bruteforce(@p);
}

print Dumper \%pos;
print "tries to find all 960 positions: $tries\n";

sub bruteforce {
    my $valid = 1;
    $tries++;
    my @p = @_;
    my @s = shuffle(@p);
    my $s = join("", @s);
    my $c = $s;
    $c =~ s/b//g;
    $c =~ s/n//g;
    $c =~ s/q//g;
    
    my $b = $s;
    $b =~ s/n/\./g;
    $b =~ s/q/\./g;
    $b =~ s/k/\./g;
    $b =~ s/r/\./g;
    
    my @b = split(//, $b);
    my $bcnt = 0;
    my $bstr = '';
    
    for (@b) {
        $bcnt++;
        $bstr .= $bcnt if $_ eq 'b';
    }
 
    my ($fb, $sb) = split(//, $bstr);
    
    if ($fb % 2 == 1 and $sb % 2 == 1) {
        $valid = 0;
    } elsif ($fb % 2 == 0 and $sb % 2 == 0) {
        $valid = 0;
    } else {
        $valid = 1;
    }
    
    $valid = 0 unless ($c eq 'rkr');
    
    warn "$tries: $s $b $fb,$sb ($c) valid: $valid\n";
    
    if ($valid == 1) {
        $pos{$s} = 1;
    }
        
    return 1 if $valid == 1;
    return 0;
}
