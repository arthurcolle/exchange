# import pandas as pd
import threading
THREAD_GROUP_SIZE = 4

def read_ugly_html(file):
    with open(file) as f:    # create a file handler that references the file
        read_data = f.read() # read the bytes
    f.closed                 # close file handler when done
    c = []          # create a charbuffer to handle reading the data

    for d in read_data:
        c.append(d)
    s = ''
    html = ''.join(c)
    return html

def parse_tag(tag):
    retval = None
    tag_flag = false # assume not a tag before doing anything else
    if tag[0] == '<' and tag[len(tag)-1]=='>':
        tag_flag = True
    if tag_flag != True:
        retval = []
    else:
        tagtype = tag.substr(1,len(tag)-1)
        retval = tagtype
    return retval

def newline_pass(html,debug=True):
    charbuffer = []
    for index,ch in enumerate(html):
        if ch=='<':
            charbuffer.append("\n")
        charbuffer.append(ch)
    if debug == True or debug == None:
        print(''.join(charbuffer))
    return charbuffer

def tag_pass(html, debug=True):
    charbuffer = []
    for index,ch in enumerate(html):
        tag_hierarchy = {}
        if ch=='\n':
            current_tag
            tag_hierarchy

def spaces(input):
    space_flag = False # no spaces to start, maybe later
    multiple_space_flag = False
    space_indices = []
    for index,i in enumerate(input):
        if i == ' ' and space_flag == False:
                     space_flag = True
        if i == ' ' and space_flag == True:
            multiple_space_flag = True
        if i == ' ':
            space_indices.append(i)
    return space_indices

def worker(text_ref, index):
    good_to_go = False
    original_index = int(index)
    while True:
        if text_ref[index] == '<':
            good_to_go = True
        if good_to_go:
            index += 1
        if text_ref[index] == '>':
            tag = text_ref.substr(original_index, index)
            if has_spaces(tag):
                tag_with_possible_metadata = tag.split(' ')

            return index

class ThreadGroup():
    def __init__(self, groupsize,functionality):
        self.group=[]
        self.group_size = groupsize
    def define_threads(self):
        for i in range(groupsize):
            if functionality==None:
                helpful_message = "must dictate behavior. please pass \n reference to method like:\n\tfunctionality=<function name>"
                if debug==True or debug==None:
                    print(helpful_message)
                    return helpful_message
            else:
                self.group.append(threading.Thread(target=functionality))
    def population():
        return self.group
    def available_threads(self, debug=True):
        active_threads = threading.enumerate()
        if debug != False:
            print(active_threads)
        available_threads = list(set(self.group).difference(active_threads))
        return available_threads # get a thread thats not doing work already

def perform_pass(html, newlines=True, indenting=True):
    processingTag = False
    for index,ch in enumerate(html):
        if ch=='<':
            processingTag = True
            # take the current index and process until you reach a '>'
        if processingTag:
            worker_thread = threadgroup.get_available_thread()

def main():
    file = 'expotrading.com.html'
    ugly_html = read_ugly_html(file)
    print(newline_pass(ugly_html))

    g = ThreadGroup(12, worker)
    threads = g.available_threads(debug=False)
    if len(threads):
        for thread in threads:
            print(thread)
    a = '<meta something=special>'
    b = '<meta something-else=not-special>'
    c = '<html>testing_other_stuff</html>'
main()
