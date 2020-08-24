# Robot Simulator

### Running the application

The application can be run in interactive mode or by loading commands from a
text file.

To run in interactive mode (from the project directory):

```
$ ruby script/cli.rb
```

To load commands from a text file (from the project directory):

```
$ ruby script/cli.rb script/example.txt
```

### Running specs

RSpec was the chosen test framework, to run the specs:

```
$ bundle exec rspec
```

To run the spec in documentation mode:

```
$ bundle exec rspec -fd
```

### Brief

The application is a simulation of a small robot moving on a board, of dimensions 5 units
x 5 units that can read in commands of the following form:

```
PLACE X,Y,DIRECTION
MOVE
LEFT
RIGHT
REPORT
```

- PLACE will put the robot on the table in position X,Y and Direction(NORTH, SOUTH, EAST or WEST).
- MOVE will move the robot one unit forward in the direction it is currently facing.
- LEFT and RIGHT will rotate the robot 90 degrees in the specified direction without changing the position of the robot.
- REPORT will print the X,Y and which direction the robot is facing. This can be in any form, but standard output is sufficient.
- When the robot is not on the board, no other command (unless exit commands and PLACE) will work.
- Input can be from a file, or from standard input, or as you choose. - Provide test data to exercise the application.

## Example Input and Output

### Example a

```
PLACE 0,0,NORTH
MOVE
REPORT
Expected output: 0,1,NORTH
```
