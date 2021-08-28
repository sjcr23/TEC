def validateAngles(angArr):
    if len(angArr) == 4 and ((angArr[0]+angArr[1]+angArr[2]+angArr[3]) == 360) :
        return 1
    return 0

def find_angles(anglesArr):
    if ( ((anglesArr[0] + anglesArr[2]) == 180) and ((anglesArr[1] + anglesArr[3]) == 180) ):
        print("YES")
    else:
        print("NO")


def main():
    cases = int(input("Insert number of cases: "))
    assert ((cases > 0) & (cases <= 10000)), "Invalid number of cases"

    indx = 1
    while (indx <= cases):
        strAngles = input("Insert the angles space-separated: ")
        angles = [int(temp)for temp in strAngles.split() if temp.isdigit()]

        if (validateAngles(angles)):
            find_angles(angles)
            indx += 1
        else:
            print("Invalid Angles")
            indx -= 1

main()