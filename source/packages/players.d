module packages.players;
import raylib;
import std.conv;
import std.stdio;
import std.math;

struct Player
{
    Vector2 position;
    Color color;
    float radius = 50;
    int points = 0;

    void drawPlayer()
    {
        DrawCircle(position.x.to!int, position.y.to!int, radius, color);
    }
}

struct Ball
{
    Vector2 position = {400.0f, 400.0f};
    Vector2 speed = {0.0f, 0.0f};
    float radius = 30;
    Color color = Colors.LIGHTGRAY;

    void drawBall()
    {
        DrawCircle(position.x.to!int, position.y.to!int, radius, color);
    }

    void update(ref Player p1, ref Player p2)
    {
        if (position.x >= 800 - radius) // right wall
        {
            position.x = 800 - radius; // bring it back in bounds if it is out of bounds
            speed.x *= -1;
        }
        if (position.x <= radius) //left wall
        {
            position.x = radius;
            speed.x *= -1;
        }

        if (position.y >= 800 - radius) //bottom wall
        {
            if(position.x >= 250 && position.x <= 550){
                p1.position = Vector2(400, 40 + p1.radius);
                p2.position = Vector2(400, 760 - p2.radius);
                position = Vector2(400.0f, 600.0f);
                speed = Vector2(0.0f, 0.0f);
                p1.points++;
            } else {
                position.y = 800 - radius;
                speed.y *= -1;
            }
        }
        if (position.y <= radius) //top wall
        {
            if(position.x >= 250 && position.x <= 550){
                p1.position = Vector2(400, 40 + p1.radius);
                p2.position = Vector2(400, 760 - p2.radius);
                position = Vector2(400.0f, 200.0f);
                speed = Vector2(0.0f, 0.0f);
                p2.points++;
            } else {
            position.y = radius;
            speed.y *= -1;
            }
        }
        position += speed;
        speed *= 0.991;
    }

    void checkCollisionWithPlayer(ref Player player)
    {
        if (CheckCollisionCircles(player.position, player.radius, position, radius))
        {
            {
                speed = ((position - player.position) / 5);
            }
        }
    }
}

void reset(ref Player p1, ref Player p2, ref Ball ball)
{
    p1.position = Vector2(400, 90);
    p2.position = Vector2(400, 710);
    ball.position = Vector2(400.0f, 400.0f);
    ball.speed = Vector2(0.0f, 0.0f);
}
