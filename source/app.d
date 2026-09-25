import std.stdio;
import std.conv;
import raylib;
import packages.players;
import std.math;

void main()
{
    auto p1 = Player();
    auto p2 = Player();
    auto ball = Ball();

    reset(p1, p2, ball); // Setup Game

    validateRaylibBinding();
    InitWindow(800, 800, "Game");
    SetTargetFPS(60);

    InitAudioDevice();
    Sound fxKick = LoadSound("source/sounds/kick.wav");
    Sound fxBounce = LoadSound("source/sounds/bounce.wav");
    Sound fxGoal = LoadSound("source/sounds/goal.wav");
    Sound fxWow = LoadSound("source/sounds/wow.wav");

    while (!WindowShouldClose())
    {
        BeginDrawing();
        ClearBackground(Colors.BLACK);
        DrawLine(0, 400, 800, 400, Colors.GRAY); // Midpoint line and circle
        DrawCircleLines(400, 400, 150, Colors.GRAY);
        DrawLine(250, 1, 550, 1, Colors.WHITE); // Top goal line and box
        DrawRectangleLines(250, 1, 300, 90, Colors.GRAY);
        DrawLine(250, 799, 550, 799, Colors.WHITE); // Bottom goal line and box
        DrawRectangleLines(250, 799, 300, -90, Colors.GRAY);
        p1.drawPlayer(); // Red player
        p2.drawPlayer(); // Blue player
        ball.drawBall();

        if (IsKeyPressed(KeyboardKey.KEY_R))
            reset(p1, p2, ball);

        DrawText(TextFormat("RED:%2i", p1.points), 20, 360, 30, Colors.RED); // Score keeping text, middle left
        DrawText(TextFormat("BLUE:%2i", p2.points), 20, 410, 30, Colors.BLUE);

        if (ball.isPlaying == 0) // MENU
        {
            DrawRectangle(0, 360, 800, 100, Colors.GRAY);

            DrawText("PRESS SPACE TO START", 200, 380, 30, Colors.WHITE);
            DrawText("PRESS 'C' FOR SINGLE PLAYER", 150, 410, 30, Colors.WHITE);

            if (IsKeyPressed(KeyboardKey.KEY_SPACE))
            {
                reset(p1, p2, ball);
                ball.isPlaying = 1;
            }

            if (IsKeyPressed(KeyboardKey.KEY_C))
            {
                reset(p1, p2, ball);
                ball.isPlaying = 2;
            }

            if (p1.points == 3)
                DrawText("RED WINS", 275, 310, 50, Colors.RED);
            if (p2.points == 3)
                DrawText("BLUE WINS", 260, 310, 50, Colors.BLUE);

        }
        else
        {
            if (IsKeyPressed(KeyboardKey.KEY_P))
            {
                p2.speedFactor = 15;
                p1.speedFactor = 15;
                ball.radius = 10;
            }

            if (IsKeyDown(KeyboardKey.KEY_RIGHT))
                p2.movePlayer(KeyboardKey.KEY_RIGHT, ball);
            if (IsKeyDown(KeyboardKey.KEY_LEFT))
                p2.movePlayer(KeyboardKey.KEY_LEFT, ball);
            if (IsKeyDown(KeyboardKey.KEY_UP))
                p2.movePlayer(KeyboardKey.KEY_UP, ball);
            if (IsKeyDown(KeyboardKey.KEY_DOWN))
                p2.movePlayer(KeyboardKey.KEY_DOWN, ball);

            if (ball.isPlaying == 1) // 2 PLAYERS MODE
            {

                if (IsKeyDown(KeyboardKey.KEY_D))
                    p1.movePlayer(KeyboardKey.KEY_D, ball);
                if (IsKeyDown(KeyboardKey.KEY_A))
                    p1.movePlayer(KeyboardKey.KEY_A, ball);
                if (IsKeyDown(KeyboardKey.KEY_W))
                    p1.movePlayer(KeyboardKey.KEY_W, ball);
                if (IsKeyDown(KeyboardKey.KEY_S))
                    p1.movePlayer(KeyboardKey.KEY_S, ball);
            }
            else // ball.isPlaying == 2 // SINGLE PLAYER MODE
            {

                Vector2 target;

                if (ball.position.y < 400) // if ball is on p1's half
                    target = ball.position; // move keys direct p1 to target if positions dont equal 
                else
                    target = Vector2(ball.position.x, 160); // if on the other half, match up x axis but stay at designated y axis

                p1.speedFactor = 3.5; // too hard nerf player 1 speed

                if (target.x < 100) // gets stuck on edges of x axis
                    target.x = 100;
                else if (target.x > 700)
                    target.x = 700;

                int horizontalBuffer = 70; // make tracking less precise to simulate variation hitting
                int verticalBuffer = 50;

                if (target.x > p1.position.x + horizontalBuffer)
                    p1.movePlayer(KeyboardKey.KEY_D, ball);
                if (target.x < p1.position.x - horizontalBuffer)
                    p1.movePlayer(KeyboardKey.KEY_A, ball);
                if (target.y > p1.position.y + verticalBuffer)
                    p1.movePlayer(KeyboardKey.KEY_S, ball);
                if (target.y < p1.position.y - verticalBuffer)
                    p1.movePlayer(KeyboardKey.KEY_W, ball);
            }

            if (ball.checkCollisionWithPlayer(p1) ||
                ball.checkCollisionWithPlayer(p2))
                if (!IsSoundPlaying(fxKick))
                    PlaySound(fxKick);

            int bounce = ball.update(p1, p2);

            if (bounce == 1)
            {
                if (!IsSoundPlaying(fxBounce))
                    PlaySound(fxBounce);
            }
            else if (bounce == 2)
            {
                if (p1.points != 3 && p2.points != 3)
                    PlaySound(fxGoal);
            }

            if (p1.points == 3 || p2.points == 3)
            {
                PlaySound(fxWow);
                ball.isPlaying = 0;
            }
        }
        EndDrawing();
    }

    UnloadSound(fxKick);
    UnloadSound(fxBounce);
    UnloadSound(fxGoal);
    UnloadSound(fxWow);
    CloseAudioDevice();
    CloseWindow();
}
