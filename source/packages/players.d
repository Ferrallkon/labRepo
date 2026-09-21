module packages.players;
import raylib;

struct Player
{
    Vector2 position;
    Vector2 size;
    Color color;
}

struct Ball
{
    Vector2 position = {500.0f, 500.0f};
    Vector2 speed = {0.0f, 0.0f};
    float radius = 20;

    // void moveBall(){

    // }

}
