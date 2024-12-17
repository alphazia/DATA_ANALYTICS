import turtle

def draw_triangle(side_length):
    """Draw a triangle with the specified side length."""
    for _ in range(6):  # 6 sides for a larger star-like triangle shape
        turtle.forward(side_length)
        turtle.left(60)

def draw_square(side_length):
    """Draw a square with the specified side length."""
    for _ in range(4):
        turtle.forward(side_length)
        turtle.left(90)

def draw_circle(radius):
    """Draw a circle with the specified radius."""
    turtle.circle(radius)

def setup_turtle():
    """Initialize the turtle settings."""
    turtle.speed(1)  # Slow speed for better visibility
    turtle.pensize(3)  # Make the shapes more visible with thicker lines

def draw_shapes(triangle_size, square_size, circle_radius):
    """Draw shapes in specific positions."""
    # Draw a bigger triangle
    turtle.penup()
    turtle.goto(-200, 150)
    turtle.pendown()
    turtle.color("blue")
    draw_triangle(triangle_size * 2)  # Scale up the triangle size

    # Draw a bigger square
    turtle.penup()
    turtle.goto(-200, -100)
    turtle.pendown()
    turtle.color("green")
    draw_square(square_size * 2)  # Scale up the square size

    # Draw a bigger circle
    turtle.penup()
    turtle.goto(150, 50)
    turtle.pendown()
    turtle.color("red")
    draw_circle(circle_radius * 2)  # Scale up the circle radius

    # Add an extra triangle for decoration
    turtle.penup()
    turtle.goto(100, -200)
    turtle.pendown()
    turtle.color("purple")
    draw_triangle(triangle_size * 3)

def main():
    """Main function to run the turtle drawing program."""
    setup_turtle()
    
    # Ask user for input
    triangle_size = int(input("Enter the side length of the triangle: "))
    square_size = int(input("Enter the side length of the square: "))
    circle_radius = int(input("Enter the radius of the circle: "))

    # Draw the shapes
    draw_shapes(triangle_size, square_size, circle_radius)

    # End the turtle program
    turtle.done()

if __name__ == "__main__":
    main()
