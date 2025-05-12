# ASM-Conways-Game-of-Life
System Architecture (32 bit x86 Assembly) exercise. (Old code)

Compilation:
gcc -m32 -o conway conway.s
./conway

<details> <summary> Input </summary>
Example input/output
(Input is Rows, Columns, Nr. Points, X Y, iterations)
7
5
13
0
0
0
2
1
2
2
0
2
1
2
3
3
2
4
1
4
2
4
4
5
3
6
1
6
2
6
</details>

<details> <summary> Output </summary>
0 1 1 0 0
1 0 0 0 0
0 0 0 0 0
0 1 0 0 0
0 0 0 0 0
1 0 1 0 0
0 1 0 0 0
</details>