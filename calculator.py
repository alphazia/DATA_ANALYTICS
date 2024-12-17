import tkinter as tk
# créer des interfaces utilisateur graphiques (GUI)
calculations= ""

def add__to_calculator(symbol):
    global calculations 
    calculations = calculations +  str(symbol)# calculation +string de symbole 
    text_result.delete(1.0,"end ") # this  how we delet the hole content of  text field in the 
    text_result.insert (1.0, calculations)# ici on a ajoute le resultat de calcules
     


    pass

def evaluate_calculator():
    #eval function in python , laises evaluer calcule eyt code python 
    global calculations 
    try:
        calculations = str(eval(calculations))
       # calculations = ""# string vide             
        text_result.delete(1.0,"end")
        text_result.insert (1.0,calculations)
    
    
    except:
        clear_the_field()
        text_result.insert(1.0,"Erreur")


        
        pass
    
    pass

def clear_the_field():
     global calculations 
     calculations = ""
     
     text_result.delete(1.0,"end")
     
     pass



root = tk.Tk()    #Tk(): Il s'agit de la fenêtre principale de votre applicatio

root.geometry("300x400")

text_result = tk.Text(root,height=4  ,width =16 ,font =("Arial",24) )
text_result.grid(columnspan=5)#The `grid()` method in Tkinter is used to place widgets (such as buttons, labels, etc.) in a grid layout within a parent widget, typically a `Tk()` instance or a `Frame`. Each widget can be placed in a specific row and column of the grid.
#grid()`: This method is used to specify that you want to place the widget using the grid geometry manager.



#*
# columnspan=5`: This option is used to specify that the widget 
# should span across multiple columns in the grid. In this case, 
# `columnspan=5` means that the widget will occupy 5 columns in the grid. # 

# *#




bt1 = tk.Button(root, text = "1", command = lambda: add__to_calculator(1),width = 4,font = ("Arial" ,14))
bt1.grid(row = 2, column = 1)
bt2 = tk.Button(root, text = "2", command = lambda: add__to_calculator(2),width = 4,font = ("Arial" ,14))
bt2.grid(row = 2, column = 2)
bt3 = tk.Button(root, text = "3", command = lambda: add__to_calculator(3),width = 4,font = ("Arial" ,14))
bt3.grid(row = 2, column = 3)
bt4 = tk.Button(root, text = "4", command = lambda: add__to_calculator(4),width = 4,font = ("Arial" ,14))
bt4.grid(row = 3, column = 1)
bt5 = tk.Button(root, text = "5", command = lambda: add__to_calculator(5),width = 4,font = ("Arial" ,14))
bt5.grid(row = 3, column = 2)
bt6 = tk.Button(root, text = "6", command = lambda: add__to_calculator(6),width = 4,font = ("Arial" ,14))
bt6.grid(row = 3, column = 3)
bt7 = tk.Button(root, text = "7", command = lambda: add__to_calculator(7),width = 4,font = ("Arial" ,14))
bt7.grid(row = 4, column = 1)
bt8 = tk.Button(root, text = "8", command = lambda: add__to_calculator(8),width = 4,font = ("Arial" ,14))
bt8.grid(row = 4, column = 2)
bt9 = tk.Button(root, text = "9", command = lambda: add__to_calculator(9),width = 4,font = ("Arial" ,14))
bt9.grid(row = 4, column = 3)
bt0 = tk.Button(root, text = "0", command = lambda: add__to_calculator(2),width = 4,font = ("Arial" ,14))
bt0.grid(row = 5, column = 2)
btright = tk.Button(root, text = ")", command = lambda: add__to_calculator(")"),width = 4,font = ("Arial" ,14))
btright.grid(row = 5, column = 3)
btleft = tk.Button(root, text = "(", command = lambda: add__to_calculator("("),width = 4,font = ("Arial" ,14))
btleft.grid(row = 5, column = 1)

btplus = tk.Button(root, text = "+", command = lambda: add__to_calculator("+"),width = 4,font = ("Arial" ,14))
btplus.grid(row = 2, column = 4)
btmin = tk.Button(root, text = "-", command = lambda: add__to_calculator("-"),width = 4,font = ("Arial" ,14))
btmin.grid(row = 3, column = 4)
btmult = tk.Button(root, text = "*", command = lambda: add__to_calculator("*"),width = 4,font = ("Arial" ,14))
btmult.grid(row = 4, column = 4)
btdiv = tk.Button(root, text = "/", command = lambda: add__to_calculator("/"),width = 4,font = ("Arial" ,14))
btdiv.grid(row = 5, column = 4)
btequals = tk.Button(root, text = "=", command = evaluate_calculator,width = 4,font = ("Arial" ,14))
btequals.grid(row = 6, column = 4, columnspan=5)
btclear = tk.Button(root, text = "C", command = clear_the_field,width = 4,font = ("Arial" ,14))
btclear.grid(row = 6, column = 2, columnspan=5)






root.mainloop()
