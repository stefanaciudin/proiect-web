<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '../php/VideoRepository.php';

if (isset($_GET['occasion'])) {
    $occasion = $_GET['occasion'];
    $videos = VideoRepository::getVideosByOccasion($occasion);

    if ($videos) {
        $response = array();
        foreach ($videos as $video) {
            $videoData = array(
                'video_id' => $video->getVideoId(),
                'link' => $video->getLink(),
                'occasion' => $video->getOccasion()
            );
            $response[] = $videoData;
        }
        echo json_encode($response);
    } else {
        http_response_code(404);
        echo json_encode(
            array('message' => 'No videos found for the given occasion.')
        );
    }
} else {
    http_response_code(400);
    echo json_encode(
        array('message' => 'Bad request. Occasion is missing.')
    );
}