module packages.players;
import raylib;
import std.conv;

struct Player
{
    Vector2 position;
    Vector2 size;
    Color color;
}



struct Ball
{
    Vector2 position = {400.0f, 400.0f};
    Vector2 speed = {0.0f, 0.0f};
    float radius = 25;
    Color color = Colors.GRAY;

    void drawBall(){
        DrawCircle(position.x.to!int, position.y.to!int, radius, color);
    }

    void update(){
        position.x += speed.x;
        position.y += speed.y;
    }

    void checkCollisionWithPlayer(Rectangle player){
        if(CheckCollisionCircleRec(position, radius, player)){
            float playerCenterX = player.x + (player.width/2.0f); // center of players x axis
            float playerCenterY = player.y + (player.height/2.0f); // center of players y axis

            if(position.x > playerCenterX){ // if ball is to the right of center
                speed.x = 1.0f; // ball move right
            } else { // if ball is to the left
                speed.x = -1.0f; // ball move left
            }
            if(position.y > playerCenterY){ // if ball is below center 
                speed.y = 1.0f; // ball move down because y axis top left is 0
            } else { // if ball is above center 
                speed.y = -1.0f; // ball move up
            }
        }
    }
}