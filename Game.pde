boolean down, left, right, space; //Movement Keys

//Player Stats, maybe move to object at someoe point
float playerXPos;
float playerYPos;
float playerXSpeed = 5;
float playerYSpeed;
float playerJumpSpeed = -20;
float playerSize = 50;

//Angle for sin() to move up and down (cannon)
float angle = 0;

//Player Sprite Image
PImage jamieson;

PImage enemy1;

//Dirt and grass of the first three levels
color grassColour = #1b5e20;
color dirtColour = #733508;

//Which level/cutscene
int mode = -1;

//Physics constants
float gravity = 0.8;
float friction = 1;

//To progress from Lore menu to start menu
boolean click = false;

//Collision testing with flag cols (end)
boolean collision = false;
boolean collisionEnd = false;

//Win and loss scenarios
boolean Win = false;
boolean death = false;

//Enemy death
boolean eneDeath = false;

//Delcaring boxes, see Box object
Box a = new Box();
Box b = new Box();
Box c = new Box();
Box d = new Box();
Box e = new Box();
Box ground = new Box();
Box rand = new Box();
Box wallR = new Box();
Box wallL = new Box();

//Declare an ememy 
Enemy ene = new Enemy();

//Declaring the Cannon object
Cannon cannon = new Cannon();

//Declaring the Bullet object
Bullet bul = new Bullet();
Bullet shot1 = new Bullet();
Bullet shot2 = new Bullet();

//Declaring the Flag object
Flag f = new Flag();

void setup()
{
  //Start with all controls as False
  left = false;
  right = false;
  space = false;
  down = false;

  size(1100, 900);

  //Loading the player sprite
  jamieson = loadImage("rossJamieson.jpg");
  
  enemy1 = loadImage("declan.jpg");

  //Player placement
  playerXPos = 100;
  playerYPos = height - playerSize;

  //Platform "a" initialization (changes every level)
  a.boxXPos = 200;
  a.boxYPos = 800;
  a.boxXSize = 100;
  a.boxYSize = 50;
  a.boxcolour = dirtColour;
  a.grassXPos = a.boxXPos - 1;
  a.grassYPos = a.boxYPos - 6;
  a.grassXSize = a.boxXSize + 1;
  a.grassYSize = a.boxYSize/5;
  a.grasscolour = grassColour;

  //Platform "b" initialization (changes every level)
  b.boxXPos = 400;
  b.boxYPos = 600;
  b.boxXSize = 100;
  b.boxYSize = 50;
  b.boxcolour = dirtColour;
  b.grassXPos = b.boxXPos - 1;
  b.grassYPos = b.boxYPos - 6;
  b.grassXSize = b.boxXSize + 1;
  b.grassYSize = b.boxYSize/5;
  b.grasscolour = grassColour;

  //Platform "c" initialization (changes every level)
  c.boxXPos = 600;
  c.boxYPos = 400;
  c.boxXSize = 100;
  c.boxYSize = 50;
  c.boxcolour = dirtColour;
  c.grassXPos = c.boxXPos - 1;
  c.grassYPos = c.boxYPos - 6;
  c.grassXSize = c.boxXSize + 1;
  c.grassYSize = c.boxYSize/5;
  c.grasscolour = grassColour;

  //Platform "d" initialization (changes every level)
  d.boxXPos = 800;
  d.boxYPos = 200;
  d.boxXSize = 100;
  d.boxYSize = 50;
  d.boxcolour = dirtColour;
  d.grassXPos = d.boxXPos - 1;
  d.grassYPos = d.boxYPos - 6;
  d.grassXSize = d.boxXSize + 1;
  d.grassYSize = d.boxYSize/5;
  d.grasscolour = grassColour;

  //Platform "e" initialization (changes every level)
  e.boxXPos = 1000;
  e.boxYPos = 100;
  e.boxXSize = 100;
  e.boxYSize = 50;
  e.boxcolour = dirtColour;
  e.grassXPos = e.boxXPos - 1;
  e.grassYPos = e.boxYPos - 6;
  e.grassXSize = e.boxXSize + 1;
  e.grassYSize = e.boxYSize/5;
  e.grasscolour = grassColour;

  //Ground initialization
  ground.boxXPos = 0;
  ground.boxYPos = height - 5;
  ground.boxXSize = width;
  ground.boxYSize = 10;
  ground.boxcolour = a.grasscolour;

  //Right Wall Initialization
  wallR.boxXPos = width;
  wallR.boxYPos = 0;
  wallR.boxXSize = 50;
  wallR.boxYSize = height;
  //Left Wall Initilaization
  wallL.boxXPos = 0;
  wallL.boxYPos = 0;
  wallL.boxXSize = -50;
  wallL.boxYSize = height;

  //Random Position and Sized Box (for test cases)
  rand.boxXPos = random(width);
  rand.boxYPos = random(height); 
  rand.boxXSize = random(200);
  rand.boxYSize = random(200);
  rand.boxcolour = 255;



  //Flag "f" Initialization (Ends Level);
  f.poleX = width - 6;
  f.poleY = 50;
  f.poleLength = 5;
  f.poleHeight = 50;
  f.dist = 10;
  f.triX1 = f.poleX;
  f.triY1 = f.poleY;
  f.triX2 = f.triX1;
  f.triY2 = f.triY1 + f.dist;
  f.triX3 = f.triX1 - 2*f.dist;
  f.triY3 = f.triY2 - f.dist/2;
  f.flagColour = #e91e63;
  f.flagTop = f.flagColour;

  //Bullet "bul"
  bul.bulletXPos = 200;
  bul.bulletYPos = height - 100;
  bul.bulletXSize = 20;
  bul.bulletYSize = 10;
  bul.bulletcolour = #7f8c8d;
  bul.bulletXSpeed = 0;
  bul.bulletYSpeed = 0.1;

  //Bullet "shot1"
  shot1.bulletXPos = 30;
  shot1.bulletYPos = 545;
  shot1.bulletXSize = 20;
  shot1.bulletYSize = 10;
  shot1.bulletcolour = 100;
  shot1.bulletXSpeed = 2.5;
  shot1.bulletYSpeed = 0.5 ;

  //Bullet "shot2"
  shot2.bulletXPos = -10;
  shot2.bulletYPos = -100;
  shot2.bulletXSize = 0;
  shot2.bulletYSize = 0;
  shot2.bulletcolour = 100;
  shot2.bulletXSpeed = 0;
  shot2.bulletYSpeed = 0;

  //Cannon "cannon"
  cannon.bodyRad = 50;
  cannon.bodyX = 0;
  cannon.bodyY = 550;
  cannon.x1 = cannon.bodyX + 5;
  cannon.y1 = cannon.bodyY - 5;
  cannon.xLen = 40;
  cannon.yLen = 10;

  //Enemy "ene"
  ene.enemyXPos = width/2;
  ene.enemyYPos = height - 50;
  ene.enemyXSize = 50;
  ene.enemyYSize = 50;
  ene.enemycolour = 0;

  ene.enemyXSpeed = 5;
  ene.enemyYSpeed = 0;
}



void draw()
{

  background(25);
  noStroke();
  //Gravity and snapping to the floor acting on the player
  playerYPos = playerYPos + playerYSpeed;
  playerYSpeed = playerYSpeed + gravity;
  if (playerYPos + playerSize > height)
  {
    playerYSpeed = 0;
  }

  //Control Scheme
  if (left == true)
  {
    playerXPos = playerXPos - playerXSpeed;
  }
  if (right == true)
  {
    playerXPos = playerXPos + playerXSpeed;
  }
  if (space == true)
  {
    playerYPos = playerYPos + playerJumpSpeed;
  }
  if (mode == -3)
  { //DEATH TEXT-----------------------------------------------------------------------------------------------------------------
    //Occurs when the player dies
    background(0);
    fill(#2874a6);
    textSize(50);
    text("You Died", 100, 300);
    textSize(30);
    text("Shame, really. Click to retry the current level", 100, 400);
    text("Or press the s key to end the game", 100, 500);
    if (mousePressed)
    {
      mode = -2;
    }
    if (keyPressed && key == 's')
    {
      exit();
    }
  } else if (mode == -1) 
  {//INTRO LORE-----------------------------------------------------------------------------------------------------------------------
    //Starts the game with a little story
    textSize(30);
    fill(255);
    text("Oh no, Mr. Jamieson has left processing open all night", 100, 200);
    text("and has been teleported into his computer.", 100, 300);
    text("With D, A, and Space, can you help Mr. Jamieson escape?", 100, 400);
    text("Press any key to move on", 100, 500);
    if (keyPressed)
    {
      mode = -2;
    }
  } else if (mode == -2)
  {//START MENU---------------------------------------------------------------------------------------------------------------------
    //Nameof game and creator
    background(0);
    fill(#2874a6);
    textSize(30);
    text("Mr. Jamieson's Coding Adventure, A Game By: Toby Smith", 100, height/2 - 100);
    textSize(40);
    text("Click to begin", 100, height/2);

    if (click == true)
    {
      mode = 0;
    }
  }
  if (mode == 0)
  {//LEVEL 1----------------------------------------------------------------------------------------------------------------------------------
    //The first level
    if (click == true)
    {
      background(#3498db);
      //Flag "F" Position and drawing
      fill(f.flagColour);
      rect(f.poleX, f.poleY, f.poleLength, f.poleHeight);
      triangle(f.triX1, f.triY1, f.triX2, f.triY2, f.triX3, f.triY3);


      //Platform "a" Position and drawing
      fill(a.boxcolour);
      rect(a.boxXPos, a.boxYPos, a.boxXSize, a.boxYSize);
      fill(a.grasscolour);
      rect(a.grassXPos, a.grassYPos, a.grassXSize, a.grassYSize);

      //Platform "b" position and drawing
      fill(b.boxcolour);
      rect(b.boxXPos, b.boxYPos, b.boxXSize, b.boxYSize);
      fill(b.grasscolour);
      rect(b.grassXPos, b.grassYPos, b.grassXSize, b.grassYSize);

      //Platform "c" position and drawing
      fill(c.boxcolour);
      rect(c.boxXPos, c.boxYPos, c.boxXSize, c.boxYSize);
      fill(c.grasscolour);
      rect(c.grassXPos, c.grassYPos, c.grassXSize, c.grassYSize);


      //Platform "d" position and drawing
      fill(d.boxcolour);
      rect(d.boxXPos, d.boxYPos, d.boxXSize, d.boxYSize);
      fill(d.grasscolour);
      rect(d.grassXPos, d.grassYPos, d.grassXSize, d.grassYSize);


      //Platform "e" position and drawing
      fill(e.boxcolour);
      rect(e.boxXPos, e.boxYPos, e.boxXSize, e.boxYSize);
      fill(e.grasscolour);
      rect(e.grassXPos, e.grassYPos, e.grassXSize, e.grassYSize);


      //Ground creation
      fill(ground.boxcolour);
      rect(ground.boxXPos, ground.boxYPos, ground.boxXSize, ground.boxYSize);

      //Right Wall Drawing
      rect(wallR.boxXPos, wallR.boxYPos, wallR.boxXSize, wallR.boxYSize);

      //Left Wall drawing
      rect(wallL.boxXPos, wallL.boxYPos, wallL.boxXSize, wallL.boxYSize);

      //Enemy drawing
      rect(ene.enemyXPos, ene.enemyYPos, ene.enemyXSize, ene.enemyYSize);
      image(enemy1, ene.enemyXPos, ene.enemyYPos, ene.enemyXSize, ene.enemyYSize);

      ene.enemyXPos = map(sin(angle), -1, 1, ene.enemyXSize, height - ene.enemyYSize);
      //ene.enemyYPos = map(sin(angle), -1, 1, ene.enemyXSize, height - ene.enemyYSize);
      angle = angle + 0.01;


      //The collision detection for each Box and wall
      collisionBoxA();
      if (collision == true)
      {
        playerYPos = a.boxYPos - playerSize;
        playerYSpeed = 0;
        gravity = 0;
      } else
      {
        gravity = 1;
      }

      collisionBoxB();
      if (collision == true)
      {
        playerYPos = b.boxYPos - b.boxYSize;
        playerYSpeed = 0;
        gravity = 0;
      } else
      {
        gravity = 1;
      }
      collisionBoxC();
      if (collision == true)
      {
        playerYPos = c.boxYPos - c.boxYSize;
        playerYSpeed = 0;
        gravity = 0;
      } else
      {
        gravity = 1;
      }


      collisionBoxD();
      if (collision == true)
      {
        playerYPos = d.boxYPos - d.boxYSize;
        playerYSpeed = 0;
        gravity = 0;
      } else
      {
        gravity = 1;
      }

      collisionBoxE();
      if (collision == true)
      {
        playerYPos = e.boxYPos - e.boxYSize;
        playerYSpeed = 0;
        gravity = 0;
      } else
      {
        gravity = 1;
      }

      collisionBoxGround();
      if (collision == true)
      {
        playerYPos = ground.boxYPos - ground.boxYSize*4;
        gravity = 0;
        playerYSpeed = 0;
      } else
      {
        gravity = 1;
      }

      collisionBoxWallR();
      if (collision == true)
      {
        right = false;
        playerXPos = wallR.boxXPos - playerSize;
      }

      collisionBoxWallL();
      if (collision == true)
      {
        left = false;
        playerXPos = 0;
      }

      endCollision();
      if (collisionEnd == true)
      {
        background(100);
        Win = true;
        mode = 1;
      }

      if (eneDeath == false)
      {
        collisionEnemy();
        if (death == true)
        {
          mode = -3;
        }
      }
      else
      {
        ene.enemyYPos = 2*height;
      }

      //Player Drawing
      rect(playerXPos, playerYPos, playerSize, playerSize);
      image(jamieson, playerXPos, playerYPos, playerSize, playerSize);
    }
  } else if (mode == 1) //LEVEL 2------------------------------------------------------------------------------------------------
  {
    //Start with death being not on
    death = false; 
    background(#3498db);

    //Reinitialize each object with new size and Position
    //Platform "a"
    a.boxXPos = 500;
    a.boxYPos = 400;
    a.boxXSize = 200;
    a.boxYSize = 175;
    a.boxcolour = #d68910;

    //Platform "b"
    b.boxXPos = 200;
    b.boxYPos = 400;
    b.boxXSize = 100;
    b.boxYSize = 50;
    b.boxcolour = #2e7d32;

    //Platform "c"
    c.boxXPos = 400;
    c.boxYPos = 300;
    c.boxXSize = 100;
    c.boxYSize = 50;
    c.boxcolour = #0d47a1;

    //Platform "ground"
    ground.boxXPos = 0;
    ground.boxYPos = height - 5;
    ground.boxXSize = width;
    ground.boxYSize = 10;
    ground.boxcolour = a.grasscolour;

    //Flag
    f.poleX = width - 6;
    f.poleY = 550;

    //Re-draw every object
    //Platform "a"
    fill(a.boxcolour);
    rect(a.boxXPos, a.boxYPos, a.boxXSize, a.boxYSize);

    //Platfrom "b"
    fill(b.boxcolour);
    rect(b.boxXPos, b.boxYPos, b.boxXSize, b.boxYSize);

    //Platform "c"
    fill(c.boxcolour);
    rect(c.boxXPos, c.boxYPos, c.boxXSize, c.boxYSize);

    //Platform "ground"
    fill(ground.boxcolour);
    rect(ground.boxXPos, ground.boxYPos, ground.boxXSize, ground.boxYSize);

    //Cannon "cannon"
    fill(100);
    ellipse(cannon.bodyX, cannon.bodyY, cannon.bodyRad, cannon.bodyRad);
    rect(cannon.x1, cannon.y1, cannon.xLen, cannon.yLen);

    //This makes the cannon move up and down cyclically
    cannon.bodyY = map(sin(angle), -1, 1, cannon.bodyRad, height - cannon.bodyRad);
    cannon.y1 = map(sin(angle), -1, 1, cannon.bodyRad, height - cannon.bodyRad) - 5;

    //Bullet Time with shot1 and shot2 
    //They both spawn halfway along from eachother
    fill(shot1.bulletcolour);
    rect(shot1.bulletXPos, shot1.bulletYPos, shot1.bulletXSize, shot1.bulletYSize);
    shot1.bulletXPos = shot1.bulletXPos + shot1.bulletXSpeed;
    shot1.bulletYPos = shot1.bulletYPos + shot1.bulletYSpeed;
    shot1.bulletYSpeed = shot1.bulletYSpeed + gravity/1000;

    fill(shot2.bulletcolour);
    rect(shot2.bulletXPos, shot2.bulletYPos, shot2.bulletXSize, shot2.bulletYSize);
    shot2.bulletXPos = shot2.bulletXPos + shot2.bulletXSpeed;
    shot2.bulletYPos = shot2.bulletYPos + shot2.bulletYSpeed;
    shot2.bulletYSpeed = shot2.bulletYSpeed + gravity/1000;

    //Player drwaing
    rect(playerXPos, playerYPos, playerSize, playerSize);
    image(jamieson, playerXPos, playerYPos, playerSize, playerSize);

    //Collision recognition for all the objects again
    collisionBoxA();
    if (collision == true)
    {
      playerYPos = a.boxYPos - playerSize;
      playerYSpeed = 0;
      gravity = 0;
    } else
    {
      gravity = 1;
    }

    collisionBoxB();
    if (collision == true)
    {
      playerYPos = b.boxYPos - playerSize;
      playerYSpeed = 0;
      gravity = 0;
    } else
    {
      gravity = 1;
    }

    collisionBoxC();
    if (collision == true)
    {
      playerYPos = c.boxYPos - playerSize;
      playerYSpeed = 0;
      gravity = 0;
    } else
    {
      gravity = 1;
    }

    collisionBoxGround();//Ground
    if (collision == true)
    {
      playerYPos = ground.boxYPos - ground.boxYSize*4;
      gravity = 0;
      playerYSpeed = 0;
    } else
    {
      gravity = 1;
    }

    collisionBoxShot1();
    {
      if (death == true)
      {
        mode = -3;
      }
    }

    collisionBoxShot2();
    {
      if (death == true)
      {
        mode = -3;
      }
    }

    //Bullet timer
    if (shot1.bulletXPos == width/2)
    {
      //Bullet "shot2"
      shot2.bulletXPos = 30;
      shot2.bulletYPos = cannon.y1;
      shot2.bulletXSize = 20;
      shot2.bulletYSize = 10;
      shot2.bulletcolour = 100;
      shot2.bulletXSpeed = 2.5;
      shot2.bulletYSpeed = 0.5;
    }

    if (shot1.bulletXPos > width - shot1.bulletXSize)
    {
      shot1.bulletXPos = 30;
      shot1.bulletYPos = cannon.y1;
      shot1.bulletXSpeed = 2.5;
      shot1.bulletYSpeed = 0.5;
    }
    if (shot2.bulletXPos > width - shot2.bulletXSize)
    {
      shot2.bulletXPos = 30;
      shot2.bulletYPos = cannon.y1;
      shot2.bulletXSpeed = 2.5;
      shot2.bulletYSpeed = 0.5;
    }
    angle = angle + 0.01;
  }
}

//KEY PRESS-------------------------------------------------------------------------------------------------------------------
void keyPressed()
{
  if (key == 'a')
  {
    left = true;
  }
  if (key == 'd')
  {
    right = true;
  }
  if (key == 's')
  {
    down = true;
  }
  if (key == ' ')
  {
    space = true;
  }
}

//KEY RELEASE------------------------------------------------------------------------------------------------------------
void keyReleased()
{
  if (key == 'a')
  {
    left = false;
  }
  if (key == 'd')
  {
    right = false;
  }
  if (key == 's')
  {
    down = false;
  }
  if (key == ' ')
  {
    space = false;
  }
}

//LEVEL 1---------------------------------------------------------------------------------------------------------------------

//This is the meat of the code and detects when the player is in the object 
void collisionBoxB() //Platfrom b
{
  //if the player is in the object using the verticies, there is a collision
  //this only works with a player length of 50 for some reason
  if ((playerXPos + playerSize > b.boxXPos && playerXPos < b.boxXPos + b.boxXSize) && (playerYPos + playerSize > b.boxYPos && playerYPos < b.boxYPos + playerSize))
  {
    collision = true;
  } else
  {
    collision = false;
  }
}

void collisionBoxA() //Platform "a" Collreg, first level
{
  if ((playerXPos + playerSize > a.boxXPos && playerXPos < a.boxXPos + a.boxXSize) && (playerYPos + playerSize > a.boxYPos && playerYPos < a.boxYPos + playerSize)) //Lmao idk
  {
    collision = true;
  } else
  {
    collision = false;
  }
}

void collisionBoxC() //Platform "c" Collreg
{
  if ((playerXPos + playerSize > c.boxXPos && playerXPos < c.boxXPos + c.boxXSize) && (playerYPos + playerSize > c.boxYPos && playerYPos < c.boxYPos + playerSize)) //Lmao idk
  {
    collision = true;
  } else
  {
    collision = false;
  }
}

void collisionBoxD() //Platform "d" Collreg
{
  if ((playerXPos + playerSize > d.boxXPos && playerXPos < d.boxXPos + d.boxXSize) && (playerYPos + playerSize > d.boxYPos && playerYPos < d.boxYPos + playerSize)) //Lmao idk
  {
    collision = true;
  } else
  {
    collision = false;
  }
}

void collisionBoxE() //Platform E colreg
{
  if ((playerXPos + playerSize > e.boxXPos && playerXPos < e.boxXPos + e.boxXSize) && (playerYPos + playerSize > e.boxYPos && playerYPos < e.boxYPos + playerSize)) //Lmao idk
  {
    collision = true;
  } else
  {
    collision = false;
  }
}

void collisionBoxGround() //Ground Collision
{
  if ((playerXPos + playerSize > ground.boxXPos && playerXPos < ground.boxXPos + ground.boxXSize) && (playerYPos + playerSize > ground.boxYPos && playerYPos < ground.boxYPos + playerSize)) //Lmao idk
  {
    collision = true;
  } else
  {
    collision = false;
  }
}

void collisionBoxWallR() //Right Wall
{
  if (playerXPos + playerSize >= wallR.boxXPos) //Lmao idk
  {
    collision = true;
  } else
  {
    collision = false;
  }
}

void collisionBoxWallL() //Left Wall
{
  if (playerXPos <= wallL.boxXPos) //Lmao idk
  {
    collision = true;
  } else
  {
    collision = false;
  }
}

void collisionBoxRand() //Platform rand colreg
{
  if ((playerXPos + playerSize > rand.boxXPos && playerXPos < rand.boxXPos + rand.boxXSize) && (playerYPos + playerSize > rand.boxYPos && playerYPos < rand.boxYPos + playerSize)) //Lmao idk
  {
    collision = true;
  } else
  {
    collision = false;
  }
}

void collisionBoxBul() //Death and Taxes
{
  if ((playerXPos + playerSize > bul.bulletXPos && playerXPos < bul.bulletXPos + bul.bulletXSize) && (playerYPos + playerSize > bul.bulletYPos && playerYPos < bul.bulletYPos + bul.bulletYSize)) //Lmao idk
  {
    death = true;
  } else
  {
    death = false;
  }
}

void collisionBoxShot1() //Death and Taxes
{
  if ((playerXPos + playerSize > shot1.bulletXPos && playerXPos < shot1.bulletXPos + shot1.bulletXSize) && (playerYPos + playerSize > shot1.bulletYPos && playerYPos < shot1.bulletYPos + shot1.bulletYSize)) //Lmao idk
  {
    death = true;
  } else
  {
    death = false;
  }
}

void collisionBoxShot2() //Death and Taxes
{
  if ((playerXPos + playerSize > shot2.bulletXPos && playerXPos < shot2.bulletXPos + shot2.bulletXSize) && (playerYPos + playerSize > shot2.bulletYPos && playerYPos < shot2.bulletYPos + shot2.bulletYSize)) //Lmao idk
  {
    death = true;
  } else
  {
    death = false;
  }
}

void collisionEnemy() //Death and Taxes
{
  if ((playerXPos + playerSize > ene.enemyXPos && playerXPos < ene.enemyXPos + ene.enemyXSize) && (playerYPos + playerSize > ene.enemyYPos && playerYPos < ene.enemyYPos + ene.enemyYSize)) //Lmao idk
  {
    if (playerYSpeed > 0)
    {
      death = false;
      ene.enemycolour = #3498db;
      eneDeath = true;
    } else 
    {
      death = true;
    }
  } else
  {
    death = false;
  }
}

//LEVEL CHANGE-------------------------------------------------------------------------------------------------------------------------
void endCollision()
{
  if ((playerXPos + playerSize > f.poleX && playerXPos < f.poleX + f.poleLength) && (playerYPos + playerSize > f.poleY && playerYPos < f.poleY + playerSize)) //Lmao idk
  {
    collisionEnd = true;
  }
}

//MOUSE PRESS----------------------------------------------------------------------------------------------------------------
void mousePressed()
{
  click = true;
}