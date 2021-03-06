/**
The Ministry of Health (MOH) has embarked on 
some programs/initiatives aimed at 
identifying and controlling certain
 lifestyle diseases such as diabetes.
 The Director of the MOH highlighted
 the need to educate the public about
 these diseases and has made the move 
 to partner with the school of computing 
 at the University 
of Technology Jamaica (UTECH) to 
create an Expert system that 
could assist the MOH in its efforts.
**/

% knowledge base for moh

% BMI WEIGHT CATEGORIES
% bmi facts

underweight([18.5]). % below 
normalweight([18.5,24.9]). % over and less than 24.9
overweight([25,29.9]) . % 25 - 29.9	Overweight
obese(30.0). % over 30


% BMI Calculations
% bmi rules
printHeight(Height):- write("Height in meters =  "), nl,(format('~3f',[Height])),classify_bmi(Height).

convertToM(CalcMeters,Height):- CalcM is (CalcMeters / 100),Height is CalcM .

convertToCm(CalcFeetInches,Height):- CalcCm is (CalcFeetInches * 2.540), convertToM(CalcCm,Height).

calculate_height(Feet,Inches,Height):- 
 CalcFeet is (Feet * 12 ), CalcFeetInches is 
 (CalcFeet + Inches), convertToCm(CalcFeetInches,Height).
 
 % calculates the body mass index of the individual, R is Height squared.
 calculate_bmi(Height,Weight,Bmi):-nl, R is (Height * Height) , Bmi is (Weight / R).
 
 %calculate  pounds weight to kilogram.
 calculate_weight(Weight,Kilogram):- Kilogram is (Weight * 0.453592).
 
 %write to file
 file_write(Name,Age,Origin,Type,Height,Weight):-
      format(atom(H),'~3f',[Height]),
		 open('expert_db.txt',write,Stream),
		 write(Stream,
		 user(user_bmi_type(Type,user_name(Name)),
			user_age(Age),
			user_weight(Weight),
			user_ethnicity(Origin),
			user_height(H))).
		 close(Stream).
 
 % bmi classification based on height(meters) and weight(pounds).
classify_bmi(Bmi,Name,Age,Origin,Height,Weight):- nl ,(Bmi >= 30.0 -> Status = 'Obese'; Bmi < 18.5 -> 
Status = 'UnderWeight'; Bmi >= 18.5 ,
 Bmi =< 24.9 -> Status = 'NormalWeight';
 Bmi >= 25 , Bmi =< 29.9 -> Status = 'OverWeight'
),nl, file_write(Name,Age,Origin,Status,Height,Weight).


bmi_input(Feet,Inches,Weight,Name,Age,Origin):-
calculate_height(Feet,Inches,Height), % returned Height in meters.
calculate_weight(Weight,Kilogram),  % returned weight in pounds.
calculate_bmi(Height,Kilogram,Bmi), % returns individual calculated body mass index.
classify_bmi(Bmi,Name,Age,Origin,Height,Kilogram). 

% next step is creae dynamic predicates
% assert each user entry in db
% write each assert to file
% use backtracking effeciently to decide or not a individualis obese based on thier bmi.
% read from file into db

% build gui to extract infomation from user.
% use jpl to process prolog commands from java



% defines the format for user input variables
% facts
user_name(Name).
user_age(Age).
user_weight(Weight).
user_ethnicity(Origin).
user_height(Height).
bmi_type([obese,underweight,overweight,normalweight]).

user_bmi_type(Type,user_name(Name)).

% facts about a user

user(user_bmi_type(Type,user_name(Name)),
user_age(Age),
user_weight(Weight),
user_ethnicity(Origin),
user_height(Height)).

/**
file_write(Name,Age,Weight,Origin,Height):-
		 open('file.txt',write,Stream), 
         write(Stream, user(user_name(Name),user_age(Age),user_weight(Weight),user_ethnicity(Origin),user_height(Height))),nl(Stream), 
         close(Stream).
		 
file_write(Name,Type):-
		 open('data.txt',write,Stream),
		 write(Stream,user_bmi_type(Type,user_name(Name))),
		 close(Stream).
**/
% inputs and test 
test_user_data(Name,Age,Weight,Origin,Feet,Inches):-
bmi_input(Feet,Inches,Weight,Name,Age,Origin). % calculate respective bmi classifiers.
