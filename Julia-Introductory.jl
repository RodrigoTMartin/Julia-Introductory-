
pwd()
cd("C:\\Users\\rodri\\OneDrive\\Escritorio\\Macro Int Cuantitativa\\Julia Introduction Course\\Julia-Introductory-")

s1 = "I am a string"
s2 = """I am also a string"""
typeof('a')

#String interpolation
name = "Jane"
num_fingers= 10
num_toes= 10

println("Hello, my name is $name.")
println("I have $num_fingers fingers and $num_toes toes.")

#String concatenation
string("How many cats ", "are too many cats?")

string("I don't know, but ", 10, " cats ", "surely aren't too few.")

s3 = "How many cats are too many cats?"
s4 = "I don't know, but "

s3*s4

#Data structures
#Dictionary
myphonebook = Dict("Jenny" => "867-5309", "Ghostbusters" => "555-2368")
#We can add another entry on this dictionary as follows
myphonebook["Julia"] = "555-1234"

myphonebook

#We can also remove an entry from the dictionary as follows
pop!(myphonebook, "Jenny")

myphonebook

#Tuples

myfavoriteanimals = ("penguins", "cats", "sugargliders")
myfavoriteanimals[1]

#Arrays

myfriends = ["Ted", "Robyn", "Barney", "Lily", "Marshall"]

fibonacci= [1, 1, 2, 3, 5, 8, 13]
mix = [1,2,3.0,"hi"]

myfriends[3]

#We can add another entry on this array as follows
push!(fibonacci,21)

pop!(fibonacci)
fibonacci

favorites = [["koobideh","chocolate","eggs"],["penguins","cats","sugargliders"]]
numbers = [[1,2,3],[10,20,30],[100,200,300]]
rand(4,3)
rand(4,3,2)


#Loops

#while Loops
n = 0
while n < 10
    n += 1
    println(n)
end
#We can mix that with strings
myfriends = ["Ted", "Robyn", "Barney", "Lily", "Marshall"]
i=1
while i <= length(myfriends)
    friend = myfriends[i]
    println("Hi $friend, it's good to see you!")
    i += 1
end
#for Loops
for n in 1:10
    println(n)
end

for friend in myfriends
    println("Hi $friend, it's good to see you!")
end

#Create some adition tables
m,n = 5,5
A = zeros(m,n)
for i in 1:m
    for j in 1:n
        A[i,j] = i + j
    end
end
A

B=zeros(m,n)
for i in 1:m, j in 1:n
    B[i,j] = i + j
end
B
C = [i+j for i in 1:m, j in 1:n]
C

for n in 1:10
    A= [i + j for i in 1:n, j in 1:n]
    display(A)
end

#Conditionals
x= 3
y= 4

if x > y
    println("$x is greater than $y")
elseif y > x
    println("$y is greater than $x")
else
    println("$x is equal to $y")
end

if x > y
    x
else
    y
end
#Thats is equivalent to:
(x>y) ? x : y
#True false condtions 

(x>y) && println("$x is greater than $y")
(x<y) && println("$x is less than $y")

#Functions
function sayhi(name)
    println("Hi $name, it's great to see you!")
end

function f(x)
    x^2
end


#we can also define functions as follows
sayhi2(name) = println("Hi $name, it's great to see you!")
f2(x) = x^2

#We can also define anonymous functions
sayhi3= name -> println("Hi $name, it's great to see you!")
f3 = x -> x^2
sayhi3("C-3PO")

#Duck-typing in Julia

sayhi(4441245)

A=rand(3,3)

f(A)

v=rand(3)

f(v)

#Mutating vs non-mutating functions

v=[3, 1, 2]
#Order
sort(v)
sort!(v)

#Broadcasting

A = [i + 3j for i in 1:3, j in 0:2]
#There are two difertents kind of function
f(A)

B=f.(A)

#Packages

using Pkg
Pkg.add("Example")


using Example
hello("It's me. I was wondering if after all these years you'd like to meet.")

Pkg.add("Colors")
using Colors

#Packages for Plots 
Pkg.add("Plots")
Pkg.add("PlotlyJS")
using Plots
using PlotlyJS

#Generate Artifitial Data
x=-3:0.1:3
f(x)=x^2
y=f.(x)

gr()

plot(x,y, label="line")
scatter!(x,y, label="points")



#Using PlotlyJS (Interactive plots).

plotlyjs()

plot(x,y, label="line")
scatter!(x,y, label="points")

#Getting slightly fancier 

globaltemperatures=[14.4,14.5,14.9,15.2,15.5,15.8]
numpirates=[45000,20000,15000,5000,400,17]

#First we plot the data
plot(numpirates, globaltemperatures, legend=false)
scatter!(numpirates, globaltemperatures, legend=false)
#This reverses x axis we can see how the temperature changes as the number of pirates decreases
xflip!()

#Add titles and labels
xlabel!("Number of Pirates [Approximate]")
ylabel!("Global Temperature (C)")
title!("Influence of pirate population on global warming")

p1=plot(x,x)
p2=plot(x,x.^2)
p3=plot(x,x.^3)
p4=plot(x,x.^4)
plot(p1,p2,p3,p4, layout=(2,2),legend=false)



#Multiple dispatch

#How much methods there are for a function
methods(+)
@which 3+3
@which 3.0+3.0
@which 3+3.0

import Base: +
#I could generate a new method for the + function that takes two strings and concatenate them
+(x::String, y::String) = string(x, y)
"hello " + "World! "

@which "hello " + "World! "
#Lets create a new function that say me which king of str I add
foo(x,y) = println("duck-typed foo!")
foo(x::Int, y::Float64) = println("foo with an integer and a float!")
foo(x::Float64, y::Float64) = println("foo with two floats!")
foo(x::Int, y::Int) = println("foo with two integers!")

foo(1,1)
foo(1.0,1.0)
foo(1,1.0)
foo(true,false)

#Julia is fast
a=rand(10^7) #1D vector of random numbers 

sum(a) #Sum of all elements of the vector

#Benchmarking a few way in a few laguages

Pkg.add("BenchmarkTools")
Pkg.add("gcc")
using BenchmarkTools

#1. The C language
#The current author does not speak C, so he does not recognize the cell below.
C_code="""
#include<stddef.h>
double c_sum(size_t n, double *X){
    double s=0.0;
    for(size_t i=0; i<n; ++i){
        s+=X[i];
    }
    return s;
}
"""

const Clib=tempname() #make a temporary  file
#Compile to a shared library by piping C_code to gcc
#Works only if you have gcc installed
open(`gcc -fPIC -O3 -ffast-math -march=native -xc -shared -o $(Clib * "." * Libdl.dlext) -`, "w") do f
    print(f, C_code)
end

#=Python built in sum
We can use Python codes in Julia=#

Pkg.add("PyCall")
using PyCall

#Call a low level PyCall function to get  Python list, because
#by default PyCall converts Julia arrays to NumPy arrays(we benchmark Numpy below):

apy_list = PyCall.array2py(a, 1, 1)

#get the python built
pysum=pybuiltin("sum")

pysum(a)

pysum(a) ≈ sum(a)

py_list_bench = @benchmark $pysum($apy_list)
d["Python built-in"] = minimum(py_list_bench.times) / 1e6

#Python with NumPy
Pkg.add("Conda")
using Conda
Conda.add("numpy")

numpy_sum = pyimport("numpy")["sum"]
apy_numpy = PyObject(a)

py_numpy_bench = @benchmark $numpy_sum($apy_numpy)


numpy_sum(apy_list)


#Basic Linear Algebra
A=rand(1:4,3,3)
B=A
C=copy(A)
[ B C]

#Watch out!
A[1]=17
[B C]

x=ones(3)

b=A*x
#Overdetermined systems
Atall = A[:,1:2]    
display(Atall)
Atall/b

