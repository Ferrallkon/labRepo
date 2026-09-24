import std.stdio;
import std.conv;
import raylib;
import packages.players;
import std.math;

void main()
{
    auto p1 = Player(Vector2(400, 90), Colors.RED);
    auto p2 = Player(Vector2(400, 710), Colors.BLUE);
    auto ball = Ball();

    validateRaylibBinding();
    InitWindow(800, 800, "Game");
    SetTargetFPS(60);

    bool isPlaying = false;

    while (!WindowShouldClose())
    {
        BeginDrawing();
        ClearBackground(Colors.BLACK);
        DrawLine(0, 400, 800, 400, Colors.GRAY); //Midpoint line and circle
        DrawCircleLines(400, 400, 150, Colors.GRAY);

        DrawLine(250, 1, 550, 1, Colors.GREEN); //Top goal line and box
        DrawRectangleLines(250, 1, 300, 90, Colors.GRAY);

        DrawLine(250, 799, 550, 799, Colors.GREEN); //Bottom goal line and box
        DrawRectangleLines(250, 799, 300, -90, Colors.GRAY);

        p1.drawPlayer(); //red player
        p2.drawPlayer(); //blue player
        ball.drawBall();

        DrawText(TextFormat("RED:%2i", p1.points), 20, 360, 20, Colors.RED); // Score keeping text, middle left
        DrawText(TextFormat("BLUE:%2i", p2.points), 20, 420, 20, Colors.BLUE);

        if (!isPlaying)
        {
            DrawText("PRESS SPACE TO START", 200, 380, 30, Colors.WHITE);
            if (IsKeyPressed(KeyboardKey.KEY_SPACE))
            {
                reset(p1, p2, ball);
                isPlaying = true;
            }

            if (p1.points == 5)
            {
                DrawText("RED WINS", 275, 320, 50, Colors.RED);
            }

            if (p2.points == 5)
            {
                DrawText("BLUE WINS", 275, 320, 50, Colors.BLUE);
            }

        }
        else
        {
            if (IsKeyPressed(KeyboardKey.KEY_R))
                reset(p1, p2, ball);

            if (IsKeyDown(KeyboardKey.KEY_D))
                p1.movePlayer(KeyboardKey.KEY_D, ball);
            if (IsKeyDown(KeyboardKey.KEY_A))
                p1.movePlayer(KeyboardKey.KEY_A, ball);
            if (IsKeyDown(KeyboardKey.KEY_W))
                p1.movePlayer(KeyboardKey.KEY_W, ball);
            if (IsKeyDown(KeyboardKey.KEY_S))
                p1.movePlayer(KeyboardKey.KEY_S, ball);

            if (IsKeyDown(KeyboardKey.KEY_RIGHT))
                p2.movePlayer(KeyboardKey.KEY_RIGHT, ball);
            if (IsKeyDown(KeyboardKey.KEY_LEFT))
                p2.movePlayer(KeyboardKey.KEY_LEFT, ball);
            if (IsKeyDown(KeyboardKey.KEY_UP))
                p2.movePlayer(KeyboardKey.KEY_UP, ball);
            if (IsKeyDown(KeyboardKey.KEY_DOWN))
                p2.movePlayer(KeyboardKey.KEY_DOWN, ball);

            ball.checkCollisionWithPlayer(p1);
            ball.checkCollisionWithPlayer(p2);
            ball.update(p1, p2);

            if (p1.points == 5 || p2.points == 5)
            {
                isPlaying = false;
            }
        }
        EndDrawing();
    }
    CloseWindow();
}
