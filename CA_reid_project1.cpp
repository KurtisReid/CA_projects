/*
Write a MIPS program that has in input an array of 8 elements containing measurements of 3 large
containers. The first two containers have a rectangular shape. The third one is cylindrical.
The values saved in the array are:
90, 80, 70, 60, 50, 40, 30, 20
where 90, 80, 70 is the height, the width and the length in meters of the first container, 60, 50, 40 is
the height, the width and the length in meters of the second container, and 30, 20 are respectively
the height and the diameter in meters of the cylindrical container.
The program must generate a new array of 6 elements that contains for each container, in order
from the first container to the third container, the perimeter or circumference, of the base of each
container, followed by the volume of each container.
The program must verify that the height, width, length, and diameter are strictly larger than zero.
*/
/*
File: CA_reid_project1.ccp

Modification member Functions:
double perimeter(double length, double width);
Pre: passed variables must be initalized, and must be > 0
Post: returns perameter
double prismvolume(double height, double width, double length);
Pre: passed variables must be initalized, and must be > 0
Post: returns volume of rectangular prisim
double circumference(double radius);
Pre: passed variables must be initalized, and must be > 0
Post: returns circumfrence of cylinder
double cylindervolume(double radius, double height);
Pre: passed variables must be initalized, and must be > 0
Post: returns volume of cylinder
void check_neg(double value);
Pre: passed variables must be initailized
Post: values are positive

*/



#include<iostream>
#include<cstdlib>
using namespace std;
//using namespace shape;

double perimeter(double length, double width);
double prismvolume(double height, double width, double length);
double circumference(double radius);
double cylindervolume(double radius, double height);
void check_neg(double value);

int main()
{
	cout << "main running" << endl;
	double r1_height = 90, 
	r1_width = 80, 
	r1_length = 70,
	r2_height = 60, 
	r2_width = 50, 
	r2_length = 40,
	c_height = 30, 
	c_diem = 20;

	double arr[8] = {r1_height, 
	r1_width, 
	r1_length,
	r2_height, 
	r2_width, 
	r2_length,
	c_height, 
	c_diem};
	
	for (int i = 0; i < 8; i++)
	{
		check_neg(arr[i]);// Checking for negitives
	}

	double radius;
	radius = arr[7] /2;
	//double arr[8] = {90,80,70,60,50,40,30,20};
	double calcarr[6];// answers are stored
	//double r1_per, r1_vol, r2_per, r2_vol, c_circ, c_vol;
	int h = 0, w = 1, l = 2;// counters for height, width, and length
	int x = 0;
	while(x < 8)
	{
		if (x < 4)
		{
			calcarr[x] = perimeter(arr[l], arr[w]);
			x++;
			calcarr[x] =  prismvolume(arr[h], arr[w], arr[l]);
			x++;
		}
		else
		{
			calcarr[x] = circumference(radius);

			x++;
			calcarr[x] =  cylindervolume(radius, arr[6]);
			x++;
		}
		h = h + 3;
		w = w + 3;
		l = l + 3;
	}
	for (int i = 0; i < 6; i++)
	{
		cout << calcarr[i] << endl;//prinintg answers
	}
	//cout << calcarr[3] << endl;
	cout << "main ended" << endl;
	return 0;




}
double perimeter(double length, double width)
{
	double perim = (2*length) + (2*width);
	return perim;
}
double prismvolume(double height, double width, double length)
{
	double vol = (height*width*length);
	return vol;
}
double circumference(double radius)
{
	double circum = (2*3.14*radius);
	return circum;
}
double cylindervolume(double radius, double height)
{
	double vol;
	radius = radius*radius;
	vol = (3.14*radius*height);
	return vol;
}
void check_neg(double value)
{
	if (value >= 0)
	{
		//cout << "x => o" << endl;
	}
	else
	{
		exit(1);
	}
}

