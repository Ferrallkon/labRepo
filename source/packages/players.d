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

        if (position.x >= 800 - radius) // rigth wall
        {
            speed.x = ((position.x - 800) / 15);
        }

        position.x += speed.x;
        position.y += speed.y;
    }

    void checkCollisionWithPlayer(Player player)
    {
        if (CheckCollisionCircles(player.position, player.radius, position, radius))
        {
            speed.x = ((position.x - player.position.x) / 15);
            speed.y = ((position.y - player.position.y) / 15);
        }
    }
}
