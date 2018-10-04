def main():
    # List of strings
    listOfwords = ["This" , "is", "a", "sample", "program"]

    '''
    Convert list of string to a string with whitespace as seperator
    '''
    # Join all the strings in list
    fullStr = ' '.join(listOfwords)

    # Print the string generated
    print("Joined String : ", fullStr)

    '''
    Convert list of string to a string with ',' as seperator
    '''
    # Join all the strings in list
    fullStr = ','.join(listOfwords)

    # Print the string generated
    print("Joined String : ", fullStr)

    '''
        Convert list that contains ints to a string with ',' as seperator
    '''

    mixList = ["This" , "is", "a", "sample", 44, 55, 66, "program"]


    # Convert mixList to a list of strings only and then join all elements in the list
    fullStr = '_'.join([str(elem) for elem in mixList ])

    # Print the string generated
    print("Joined String : ", fullStr)

if __name__ == '__main__':
  main()
