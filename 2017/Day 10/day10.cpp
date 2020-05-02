#include <iostream>
#include <vector>
#include <iomanip>
#include <fstream>
#include <algorithm>


#define LENGTH 256

std::string readFile( std::ifstream &in_str){
    std::string temp;
    while (in_str >> temp) {
        continue;
    }
    return temp;
}
void readFilePartOne(std::vector<int> &raw_data, std::string & input) { //Dumb and stupid way of doing this

   

    std::string num;
    for (int i = 0; i < input.size(); ++i)
    {
        if (input[i] == ',')
        {   
            raw_data.push_back(std::stoi(num));
            num = "";
        }
        else{
            num += input[i];
        }
    }
    raw_data.push_back(std::stoi(num));
}

void readFilePartTwo(std::vector<int> &raw_data, std::string & input) { 

   
    std::string num;
    for (int i = 0; i < input.size(); ++i)
    {
        
        raw_data.push_back(int(input[i]));
    }
    raw_data.push_back(17);
    raw_data.push_back(31);
    raw_data.push_back(73);
    raw_data.push_back(47);
    raw_data.push_back(23);

}
void twist(std::vector<int> &input, int rounds){

    std::vector<int> mainList;
    for (int i = 0; i < LENGTH; ++i)
    {
        mainList.push_back(i);
    }

    int index = 0;
    int skipSize = 0;
    int roundCount = 0;
    while (roundCount < rounds){
        for (int i = 0; i < input.size(); ++i)
        {
           std::vector<int> selectedIndexes;

           for (int j = 0; j < input[i]; ++j)
           {
               selectedIndexes.push_back(mainList[(j + index) % LENGTH]);
           }

          
            std::vector<int> selectedIndexesReversed(selectedIndexes.size());
            std::reverse_copy(std::begin(selectedIndexes), std::end(selectedIndexes), std::begin(selectedIndexesReversed));

            for (int j = 0,  k = 0; j < input[i]; ++j, ++k)
            {
                 mainList[(j + index) % LENGTH] = selectedIndexesReversed[k];
            }
            index += input[i] + skipSize;
            skipSize++;

        }
        roundCount++;
    }

    if (rounds == 1)
    {
        std::cout<<mainList[0] * mainList[1]<<std::endl;
        return;
        /* code */
    }
    std::vector<int> denseHash;

    for (int i = 0; i < 256; i += 16)
    {
        //Ewww
        denseHash.push_back(mainList[i] ^ mainList[i + 1] ^ mainList[i + 2] ^ mainList[i+ 3] ^ mainList[i + 4] ^ mainList[i + 5] ^ mainList[i + 6] ^ mainList[i + 7] ^ mainList[i + 8] ^ mainList[i + 9] ^ mainList[i + 10] ^ mainList[i + 11] ^ mainList[i + 12] ^ mainList[i + 13] ^ mainList[i + 14] ^ mainList[i + 15]);
    }
    for (int i = 0; i < denseHash.size(); ++i)
    {
       std::cout << std::hex <<denseHash[i];
    }
    std::cout<<std::endl;

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

    std::string inputValue = readFile(in_str);
    std::vector<int> inputData;

    readFilePartOne(inputData, inputValue);
    twist(inputData, 1);
    inputData.clear();
    readFilePartTwo(inputData, inputValue);
    twist(inputData, 64);

    

  
    
    return 0;
}