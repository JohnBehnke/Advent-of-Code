#include <string>
#include <iostream>
#include <vector>
#include <map>
#include <fstream>
#include <iomanip>
#include <iostream>



void readFile(std::vector<std::string> &raw_data, std::ifstream &in_str) {

    std::string temp;
    while (in_str >> temp) {
        raw_data.push_back(temp);
    }
}


void problem(std::vector<std::string> &input){

	std::map<std::string, int> registers;
	int largestRegisterTotal = 0; //For part two
	for (int i = 0; i < input.size(); ++i)
	{
		if (input[i] == "inc" || input[i] == "dec")
		{
			std::string targetReg = input[i - 1];
			std::string opAmount = input[i + 1];
			std::string testReg = input[i + 3];
			std::string op = input[i + 4];
			std::string test = input[i + 5];



			if (registers.find(targetReg) == registers.end())
			{
				registers[targetReg] = 0;
			}
			if (registers.find(testReg) == registers.end())
			{
				registers[testReg] = 0;
			}

			if (op == ">")
			{
				if (registers[testReg] > std::stoi(test))
				{
					if (input[i] == "inc")
					{
						registers[targetReg] += std::stoi(opAmount);
					} else{
						registers[targetReg] -= std::stoi(opAmount);
					}	
				}
			}
			if (op == "<")
			{
				if (registers[testReg] < std::stoi(test))
				{
					if (input[i] == "inc")
					{
						registers[targetReg] += std::stoi(opAmount);
					} else{
						registers[targetReg] -= std::stoi(opAmount);
					}	
				}
			}
			if (op == ">=")
			{
				if (registers[testReg] >= std::stoi(test))
				{
					if (input[i] == "inc")
					{
						registers[targetReg] += std::stoi(opAmount);
					} else{
						registers[targetReg] -= std::stoi(opAmount);
					}	
				}
			}
			if (op == "<=")
			{
				if (registers[testReg] <= std::stoi(test))
				{
					if (input[i] == "inc")
					{
						registers[targetReg] += std::stoi(opAmount);
					} else{
						registers[targetReg] -= std::stoi(opAmount);
					}	
				}
			}
			if (op == "!=")
			{
				if (registers[testReg] != std::stoi(test))
				{
					if (input[i] == "inc")
					{
						registers[targetReg] += std::stoi(opAmount);
					} else{
						registers[targetReg] -= std::stoi(opAmount);
					}	
				}
			}
			if (op == "==")
			{
				if (registers[testReg] == std::stoi(test))
				{
					if (input[i] == "inc")
					{
						registers[targetReg] += std::stoi(opAmount);
					} else{
						registers[targetReg] -= std::stoi(opAmount);
					}	
				}
			}

			//For part two
			if (registers[targetReg] > largestRegisterTotal)
			{
				largestRegisterTotal = registers[targetReg];
			}

		}
	}

	//For part one
	int largestRegister = 0;
	std::map<std::string, int>::iterator itr= registers.begin();
	for (; itr != registers.end(); ++itr)
	{
		if (itr->second > largestRegister)
		{
			largestRegister = itr->second;
		}
	}

	std::cout << largestRegister << std::endl;
	std::cout << largestRegisterTotal << std::endl;


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

    std::vector<std::string> inputData;

    readFile(inputData, in_str);
    problem(inputData);
    return 0;
}