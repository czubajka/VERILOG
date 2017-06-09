/* Projekt A,
 
	sieć sortująca N=6
	za pomocą algorytmu Bose-Nelson'a
	wykonała: 
	Karolina Nędza-Sikoniowska 
	
	model sieci ze strony jgamble.ripco.net:
	
	Network for N=6, using Bose-Nelson Algorithm.

o-----^--^--^-----------------o  0 we/wy
      |  |  |                  
o--^--|--v--|--^--------^-----o  1 we/wy
   |  |     |  |        |      
o--v--v-----|--|--^--^--|--^--o  2 we/wy
            |  |  |  |  |  |   
o-----^--^--v--|--|--|--v--v--o  3 we/wy
      |  |     |  |  |         
o--^--|--v-----v--|--v--------o  4 we/wy
   |  |           |            
o--v--v-----------v-----------o  5 we/wy

There are 12 comparators in this network,
grouped into 6 parallel operations.

[[1,2],[4,5]]
[[0,2],[3,5]]
[[0,1],[3,4],[2,5]]
[[0,3],[1,4]]
[[2,4],[1,3]]
[[2,3]]

This is graphed in 9 columns.
*/
	
module komparator (wyjscie_1, wyjscie_2, wejscie_1, wejscie_2);

input [3:0] wejscie_1;	
input [3:0] wejscie_2;		//dwa wejscia dla dwoch liczb do porownania
output reg [3:0] wyjscie_1;		//wyjscie dla liczby mniejszej
output reg [3:0] wyjscie_2;		//wyjscie dla liczby wiekszej


// porównanie

always @ (wejscie_1 or wejscie_2)    //lista czuła na poziom dla układu kombinacyjnego
	begin
		if (wejscie_1 <= wejscie_2)
			begin
				wyjscie_1 = wejscie_1;
				wyjscie_2 = wejscie_2;
			end
		else		//gdy liczba na wejsciu_1 jest wieksza od wejscia_2, zmieniam kolejnosc
			begin
				wyjscie_1 = wejscie_2;
				wyjscie_2 = wejscie_1;
			end
	end

endmodule
// koniec komparatora	

// model sieci
module siec (wyjscie_0, wyjscie_1, wyjscie_2, wyjscie_3, wyjscie_4, wyjscie_5, wejscie_0, wejscie_1, wejscie_2, wejscie_3, wejscie_4, wejscie_5);

				//wejscia
				input [3:0] wejscie_0, wejscie_1, wejscie_2, wejscie_3, wejscie_4, wejscie_5;
				
				//wyjscia
				output wire [3:0] wyjscie_0, wyjscie_1, wyjscie_2, wyjscie_3, wyjscie_4, wyjscie_5;
				
				//polaczenia
				wire [3:0] wyjscie_gora_1_2, wyjscie_dol_1_2;
				wire [3:0] wyjscie_gora_4_5, wyjscie_dol_4_5;
				
				wire [3:0] wyjscie_gora_0_2, wyjscie_dol_0_2;
				wire [3:0] wyjscie_gora_3_5, wyjscie_dol_3_5;
				
				wire [3:0] wyjscie_gora_0_1, wyjscie_dol_0_1;
				wire [3:0] wyjscie_gora_3_4, wyjscie_dol_3_4;
				wire [3:0] wyjscie_gora_2_5, wyjscie_dol_2_5;
				
				wire [3:0] wyjscie_gora_0_3, wyjscie_dol_0_3;
				wire [3:0] wyjscie_gora_1_4, wyjscie_dol_1_4;
				
				wire [3:0] wyjscie_gora_2_4, wyjscie_dol_2_4;
				wire [3:0] wyjscie_gora_1_3, wyjscie_dol_1_3;
				
				wire [3:0] wyjscie_gora_2_3, wyjscie_dol_2_3;
				
				
		//12 komparatorów:
		
	komparator k_1_2(.wyjscie_1(wyjscie_gora_1_2), .wyjscie_2(wyjscie_dol_1_2), .wejscie_1(wejscie_1), .wejscie_2(wejscie_2));
	komparator k_4_5(.wyjscie_1(wyjscie_gora_4_5), .wyjscie_2(wyjscie_dol_4_5), .wejscie_1(wejscie_4), .wejscie_2(wejscie_5));
	
	komparator k_0_2(.wyjscie_1(wyjscie_gora_0_2), .wyjscie_2(wyjscie_dol_0_2), .wejscie_1(wejscie_0), .wejscie_2(wyjscie_dol_1_2));
	komparator k_3_5(.wyjscie_1(wyjscie_gora_3_5), .wyjscie_2(wyjscie_dol_3_5), .wejscie_1(wejscie_3), .wejscie_2(wyjscie_dol_4_5));
	
	komparator k_0_1(.wyjscie_1(wyjscie_gora_0_1), .wyjscie_2(wyjscie_dol_0_1), .wejscie_1(wyjscie_gora_0_2), .wejscie_2(wyjscie_gora_1_2));
	komparator k_3_4(.wyjscie_1(wyjscie_gora_3_4), .wyjscie_2(wyjscie_dol_3_4), .wejscie_1(wyjscie_gora_3_5), .wejscie_2(wyjscie_gora_4_5));
	komparator k_2_5(.wyjscie_1(wyjscie_gora_2_5), .wyjscie_2(wyjscie_dol_2_5), .wejscie_1(wyjscie_dol_0_2), .wejscie_2(wyjscie_dol_3_5));
	
	komparator k_0_3(.wyjscie_1(wyjscie_gora_0_3), .wyjscie_2(wyjscie_dol_0_3), .wejscie_1(wyjscie_gora_0_1), .wejscie_2(wyjscie_gora_3_4));
	komparator k_1_4(.wyjscie_1(wyjscie_gora_1_4), .wyjscie_2(wyjscie_dol_1_4), .wejscie_1(wyjscie_dol_0_1), .wejscie_2(wyjscie_dol_3_4));
	
	komparator k_2_4(.wyjscie_1(wyjscie_gora_2_4), .wyjscie_2(wyjscie_dol_2_4), .wejscie_1(wyjscie_gora_2_5), .wejscie_2(wyjscie_dol_1_4));
	komparator k_1_3(.wyjscie_1(wyjscie_gora_1_3), .wyjscie_2(wyjscie_dol_1_3), .wejscie_1(wyjscie_gora_1_4), .wejscie_2(wyjscie_dol_0_3));
	
	komparator k_2_3(.wyjscie_1(wyjscie_gora_2_3), .wyjscie_2(wyjscie_dol_2_3), .wejscie_1(wyjscie_gora_2_4), .wejscie_2(wyjscie_dol_1_3));
	
		//końcowe przypisanie
	assign wyjscie_0 = wyjscie_gora_0_3;
	assign wyjscie_1 = wyjscie_gora_1_3;
	assign wyjscie_2 = wyjscie_gora_2_3;
	assign wyjscie_3 = wyjscie_dol_2_3;
	assign wyjscie_4 = wyjscie_dol_2_4;
	assign wyjscie_5 = wyjscie_dol_2_5;
	
		
endmodule				