words := RECORD
	STRING1 alpha;
END;

SET OF STRING1 alphabets:= ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 
'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];

no_of_alphabets := COUNT(alphabets);
word := DATASET([{'x'}], words);
max_length := 20;

words generate_alpha := TRANSFORM
  SELF.alpha := 'X';
END;

words tAlpha(words L) := TRANSFORM
	SELF.alpha := alphabets[RANDOM()%no_of_alphabets];
END;


// Generate a string of 'x' with random length
case_alpha := NORMALIZE(word, RANDOM()%max_length, generate_alpha);

OUTPUT(PROJECT(case_alpha, tAlpha(LEFT)));


/*
words generate:= TRANSFORM
  case_alpha := NORMALIZE(word, RANDOM()%max_length, generate_alpha);
	SELF.alpha := PROJECT(case_alpha, tAlpha(LEFT));
END;

C := 100;
list_of_words := NORMALIZE(word, C, generate);
OUTPUT(list_of_words);
*/

