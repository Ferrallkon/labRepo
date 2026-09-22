module packages.players;
import raylib;
import std.conv;
import std.stdio;

struct Player
{
    Vector2 position;
    Color color;
    float radius = 50;

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
    Color color = Colors.GRAY;

    void drawBall()
    {
        DrawCircle(position.x.to!int, position.y.to!int, radius, color);
    }

    void update()
    {
        if(position.x >= 800 - radius) // right wall
        {
            position.x = 800 - radius; // bring it back in bounds if it is out of bounds
            speed.x *= -1;
        }
        if(position.x <= radius) //left wall
        {
            position.x = radius;
            speed.x *= -1;
        }
        if(position.y >= 800 - radius) //bottom wall
        {
            position.y = 800 - radius;
            speed.y *= -1;
        }
        if(position.y <= radius) //top wall
        {
            position.y = radius;
            speed.y *= -1;
        }
        position.x += speed.x;
        position.y += speed.y;
        speed.x *= 0.991;
        speed.y *= 0.991;
    }

    void checkCollisionWithPlayer(Player player)
    {
        if (CheckCollisionCircles(player.position, player.radius, position, radius))
        {
            speed.x = ((position.x - player.position.x) / 10);
            speed.y = ((position.y - player.position.y) / 10);
        }
    }
}

void reset(ref Player p1, ref Player p2, ref Ball ball)
{
	p1.position = Vector2(50, 50);
	p2.position = Vector2(750, 750);
	ball.position = Vector2(400.0f, 400.0f);
	ball.speed = Vector2(0.0f, 0.0f);
}