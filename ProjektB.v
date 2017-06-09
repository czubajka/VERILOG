
module Licznik_Mod12 (clk, reset, tryb, wyjscie);

parameter modulo = 12;
parameter bity = 4;

input clk, reset;							// zegar, zerowanie licznika
input [1:0] tryb; 						//tryb
output wire wyjscie;     				//wyjście

reg [bity-1:0] licznik;
reg [bity-1:0] licznik_next;

//parametry trybów

parameter [1:0] licz_plus_1 = 2'b01;
parameter [1:0] licz_minus_1 = 2'b10;
parameter [1:0] stop = 2'b00;
parameter [1:0] dziel_2 = 2'b11;

//parametr zakresu
parameter [3:0] max = 4'b1011;


always @(posedge clk, posedge reset)

	if (reset)
	licznik <= 4'b0000;    //zerowanie
	else
	licznik <= licznik_next;
		
// tryby
always @(*)	
	case (tryb)
		stop : licznik_next <= licznik;						           //stop
		licz_plus_1 : licznik_next <= (licznik + 1)%modulo;        // plus 1
		licz_minus_1 : 
				if (licznik == 0) licznik_next <= (max)%modulo;
				else licznik_next <= (licznik - 1)%modulo;       	  // minus 1
		dziel_2 : licznik_next <= (licznik >> 1)%modulo;           // dziel przez 2
		//default: licznik_next <= licznik;
	endcase
 
assign wyjscie = (licznik >= 5 ? 1 : 0);

endmodule
