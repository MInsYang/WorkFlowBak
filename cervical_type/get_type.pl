#use autodie;
#blast+ m6
open IN,"$ARGV[0]";
$i="0";
while(<IN>){
   chomp;
   @array=split/\t/;
   $array[1]=~/(HPV\d+)/;
   $type=$1;
   if(exists $hash{$array[0]} && $count{$array[0]}<2){
     if($type==$type{$array[0]}){
        @new=join("\t",@array);
        $hash{$array[0]}=join("\n",$hash{$array[0]},@new);
        $count{$array[0]}=2;
     }
   }elsif(not exists $hash{$array[0]}){
      $hash{$array[0]}=join("\t",@array);
      $type{$array[0]}=$type;
      $count{$array[0]}=1;
   }   
}
open OUT1,">$ARGV[0].tab";
open OUT2,">$ARGV[0].type";
foreach $key (keys %hash){
   print OUT1 "$hash{$key}\n";
   print OUT2 "$type{$key}\n";
   $sum{$type{$key}}++;
}
foreach $sum (keys %sum) {
     print "$sum:$sum{$sum} reads\n";
}

