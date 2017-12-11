#include <iostream>
#include <vector>
#include <iomanip>
#include <fstream>


void readFile(std::string &raw_data, std::ifstream &in_str) {

    
    while (in_str >> raw_data) {
        continue;
    }
}

void problem(std::string & input){
    bool inGarbage = false;
    int level = 0;
    std::vector<int> levels;
    bool shouldIgnore = false;
    int inGarbageCount = 0;
    for (int i = 0; i < input.size(); i++)
    {
        if (shouldIgnore){ 
            shouldIgnore = false; 
            continue;
        }
        
        if (input[i] == '>' ){
            inGarbage = false;
            continue;
        }
        if (input[i] == '<' && !inGarbage){
            inGarbage = true;

            continue;
        }
        
        if (input[i] == '!'){ 
            shouldIgnore = true;
            continue;
        }
       
        if (input[i] == '{' && !shouldIgnore && !inGarbage)
        {
            level++;
            levels.push_back(level);
        }
         if (input[i] == '}' && !shouldIgnore && !inGarbage)
        {
            level--;
        }
        if (inGarbage){
            inGarbageCount++;
            continue;   
        }
        
    }
    int sum = 0;
    for (int i = 0; i < levels.size(); i++){
        sum += levels[i];
    }
    std::cout << sum << std::endl;
    std::cout << inGarbageCount << std::endl;
}
int main(int argc, char const *argv[])
{
	if (argc != 2)
	{
		std::cerr << "Usage:\n " << argv[0] << " inputFile\n";
        return 1;
	}

	std::ifstream in_str(argv[1]);

	if (!in_str) {
        std::cerr << "Could not open " << argv[1] << " to read\n";
        return 1;
    }

    std::string inputData;



    readFile(inputData, in_str);
    problem(inputData);
    return 0;
}