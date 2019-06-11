// **********************************************************************************
// TITLE       : SURF Algorithm - Determinant calculation
// AUTHOR      : Haelim Jung
// AFFILIATION : Embedded systems Lab. Dept. of CS, Sookmyung Women's University
// DESCRIPTION : Image resolution 640x480
// **********************************************************************************

#include <stdio.h>
#include <stdlib.h>
#define COL 320
#define ROW 240
#define DetMSize 75516

const int size = 9;
const int Dx[15] = {
    642, 2247, 645, 2250, 1,
    645, 2250, 648, 2253, -1,
    648, 2253, 651, 2256, 1};
const int Dy[15] = {
    2, 965, 7, 970, 1,
    965, 1928, 970, 1933, -1,
    1928, 2891, 1933, 2896, 1};
const int Dxy[20] = {
    322, 1285, 325, 1288, 1,
    326, 1289, 329, 1292, -1,
    1606, 2569, 1609, 2572, -1,
    1610, 2573, 1613, 2576, 1};

void calcDeterminant(unsigned short integralImage[(COL + 1) * (ROW + 1)], unsigned short determinantM[DetMSize])
{
    int endi = 1 + (ROW - size);
    int endj = 1 + (COL - size);
    int margin = size / 2;
    int i = 0, j = 0, k = 0;
    int layerStep = COL;
    int dx = 0, dy = 0, dxy = 0;

    for (i = 0; i < endi; i++)
    {
        for (j = 0; j < endj; j++)
        {
            dx = 0;
            dy = 0;
            dxy = 0;
            for (k = 0; k < 15; k += 5)
            {
                dx += (integralImage[i * (COL + 1) + j + Dx[k]] + integralImage[i * (COL + 1) + j + Dx[k + 3]] - integralImage[i * (COL + 1) + j + Dx[k + 1]] - integralImage[i * (COL + 1) + j + Dx[k + 2]]) * Dx[k + 4];
                dy += (integralImage[i * (COL + 1) + j + Dy[k]] + integralImage[i * (COL + 1) + j + Dy[k + 3]] - integralImage[i * (COL + 1) + j + Dy[k + 1]] - integralImage[i * (COL + 1) + j + Dy[k + 2]]) * Dy[k + 4];
                dxy += (integralImage[i * (COL + 1) + j + Dxy[k]] + integralImage[i * (COL + 1) + j + Dxy[k + 3]] - integralImage[i * (COL + 1) + j + Dxy[k + 1]] - integralImage[i * (COL + 1) + j + Dxy[k + 2]]) * Dxy[k + 4];
            }
            dxy += (integralImage[i * (COL + 1) + j + Dxy[k]] + integralImage[i * (COL + 1) + j + Dxy[k + 3]] - integralImage[i * (COL + 1) + j + Dxy[k + 1]] - integralImage[i * (COL + 1) + j + Dxy[k + 2]]) * Dxy[k + 4];
            determinantM[((i + margin) * layerStep + margin) + j] = dx * dy - (dxy * dxy / 2);
        }
    }
}