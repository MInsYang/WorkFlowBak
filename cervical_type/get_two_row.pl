#use autodie;
#blast+ m6
open IN,"$ARGV[0]";
$i="0";
while(<IN>){
   chomp;
   @array=split/\t/;
   if(exists $hash{$array[0]} && $count{$array[0]}<2){
     @new=join("\t",@array);
     $hash{$array[0]}=join("\n",$hash{$array[0]},@new);
     $count{$array[0]}=2;
   }elsif(not exists $hash{$array[0]}){
      $hash{$array[0]}=join("\t",@array);
      $count{$array[0]}=1;
   }   
}
foreach $key (keys %hash){
   print "$hash{$key}\n";
}
