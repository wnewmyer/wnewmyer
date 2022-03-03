#!/usr/bin/perl -w
use diagnostics;
use Win32;
@inputs = glob('*.out');
#unlink ("keffout.txt");
open(KEFFOUT, '>', '.\keffout.txt') or die("Can't write to keffout.txt");
foreach (@inputs) { 
	open(OUTFILE,'<',$_) or die("File $_ not found");
	foreach (split(/_/,substr($_,0,-4))) {print KEFFOUT "$_ "};  
	while ($string = <OUTFILE>) {
	  if($string =~ /final est/) {
		@results = split(/ /,$string);
		@results = grep /\S/, @results;
		print KEFFOUT $results[8]," ";
		print KEFFOUT $results[15]," ";
		print KEFFOUT $results[8]+2*$results[15];
	  last;
	  }
	}
	print KEFFOUT "\n";
	close(OUTFILE);
}
close(KEFFOUT);
open(KEFFOUT,'<', '.\keffout.txt') or die("Can't read from keffout.txt");
while (<KEFFOUT>){
    $current_line = $_;
    @line = split/ /,$_;
	$i=0;
    foreach(@line){
	  if($line[$i] =~ /^-?\d+$/) {
      $keffline{$line[$i++]} = $current_line;
	  last;
	  }
	else{$i++};
	}
#	print @line;
}
close(KEFFOUT);
open(KEFFOUT, '>', '.\keffout.txt') or die("Can't write to keffout.txt");
foreach $case (sort {$a <=> $b} keys %keffline) {
    print KEFFOUT $keffline{$case};
}


sub MsgBox {
 my($param) = @_;                                      
 Win32::MsgBox("$param");
}