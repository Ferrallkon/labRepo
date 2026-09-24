module packages.players;
import raylib;
import std.conv;
import std.stdio;
import std.math;
import core.thread;
import core.time;

struct Player
{
    Vector2 position;
    Color color;

    int radius = 50;
    int points = 0;

    const speedFactor = 7.5;

    void drawPlayer()
    {
        DrawCircle(position.x.to!int, position.y.to!int, radius, color);
        DrawCircle(position.x.to!int, position.y.to!int, radius / 2, Colors.BLACK);
    }

    void movePlayer(KeyboardKey key, Ball ball)
    {
        if (key == KeyboardKey.KEY_RIGHT || key == KeyboardKey.KEY_D)
            position.x += speedFactor;
        if (key == KeyboardKey.KEY_LEFT || key == KeyboardKey.KEY_A)
            position.x -= speedFactor;
        if (key == KeyboardKey.KEY_UP || key == KeyboardKey.KEY_W)
            position.y -= speedFactor;
        if (key == KeyboardKey.KEY_DOWN || key == KeyboardKey.KEY_S)
            position.y += speedFactor;

        fitInsideBoundaries(key);

        avoidBallOverlap(key, ball);
    }

    void fitInsideBoundaries(KeyboardKey key)
    {
        if (position.x >= 800 - radius) // right wall
            position.x = 800 - radius;

        if (position.x <= radius) // left wall
            position.x = radius;

        if (key == KeyboardKey.KEY_S)
            if (position.y >= 400 - radius) // middle wall
                position.y = 400 - radius;

        if (key == KeyboardKey.KEY_UP)
            if (position.y <= 400 + radius) // middle wall
                position.y = 400 + radius;

        if (position.y >= 800 - radius) // bottom wall
            position.y = 800 - radius;

        if (position.y <= radius) // top wall
            position.y = radius;
    }

    void avoidBallOverlap(KeyboardKey key, Ball ball)
    {
        if (CheckCollisionCircles(position, radius - speedFactor, ball.position, ball.radius))
        {
            if (key == KeyboardKey.KEY_RIGHT || key == KeyboardKey.KEY_D)
            {
                position.x -= speedFactor;
                // (position - ball.position).y > 0 ? (position.y += 1) : (position.y -= 1);
            }
            if (key == KeyboardKey.KEY_LEFT || key == KeyboardKey.KEY_A)
            {
                position.x += speedFactor;
                // (position - ball.position).y > 0 ? (position.y += 1) : (position.y -= 1);
            }
            if (key == KeyboardKey.KEY_UP || key == KeyboardKey.KEY_W)
            {
                position.y += speedFactor;
                // (position - ball.position).x > 0 ? (position.x += 1) : (position.x -= 1);
            }
            if (key == KeyboardKey.KEY_DOWN || key == KeyboardKey.KEY_S)
            {
                position.y -= speedFactor;
                // (position - ball.position).x > 0 ? (position.x += 1) : (position.x -= 1);
            }
        }
    }

    void kickAnimation()
    {
        const sizeFactor = 10;

        if (radius == Player.init.radius)
            radius += sizeFactor;

        new Thread({
            Thread.sleep(150.msecs);
            if (radius == Player.init.radius + sizeFactor)
                radius -= sizeFactor;
        }).start();
    }
}

struct Ball
{
    Vector2 position = {400, 400};
    Vector2 speed = {0, 0};

    Color color = Colors.LIGHTGRAY;

    int radius = 30;

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
            if (position.x >= 250 && position.x <= 550)
            {
                p1.position = Vector2(400, 40 + p1.radius);
                p2.position = Vector2(400, 760 - p2.radius);
                position = Vector2(400.0f, 600.0f);
                speed = Vector2(0.0f, 0.0f);
                p1.points++;
            }
            else
            {
                position.y = 800 - radius;
                speed.y *= -1;
            }
        }
        if (position.y <= radius) //top wall
        {
            if (position.x >= 250 && position.x <= 550)
            {
                p1.position = Vector2(400, 40 + p1.radius);
                p2.position = Vector2(400, 760 - p2.radius);
                position = Vector2(400.0f, 200.0f);
                speed = Vector2(0.0f, 0.0f);
                p2.points++;
            }
            else
            {
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

                player.kickAnimation();
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
