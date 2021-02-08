from launch import LaunchDescription
from launch_ros.actions import Node


def generate_launch_description():
    return LaunchDescription([
        Node(
            package='turtlesim',
            namespace='turtlesim',
            executable='turtlesim_node',
            name='sim',
            parameters=[
                {"background_r": 255},
                {"background_b": 0},
                {"background_g": 0},
            ]
        ),
    ])
