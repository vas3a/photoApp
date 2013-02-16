<?php

namespace Acme\ApiBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\Serializer\Serializer;
use Symfony\Component\Serializer\Encoder\JsonEncoder;
use Symfony\Component\Serializer\Normalizer\GetSetMethodNormalizer;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;

class PhotosController extends Controller{
	
	public function getOneAction($id){
		$photo = $this->getPhotoManager()->find($id);
		return $this->respond( $photo );
	}
	public function getAllAction(Request $request){
		$index = $request->query->get('index');
		$photo = $this->getPhotoManager()->findAll( $index );
		return $this->respond( $photo );
	}
	public function setOneAction($id, Request $request){
		$data = $request->getContent();
		$serializer = $this->getSerializer();

		$photo = $serializer->deserialize($data, 'Acme\AppBundle\Entity\Photo', 'json');
		$photo->setId($id);

		// $em = $this->getDoctrine()->getEntityManager();
		// $em->persist($photo);
		// $em->flush();
		$this->getPhotoManager()->update($photo);

		return $this->respond( '1' );
	}

	/** 
	*	@return PhotoManager
	*/
	protected function getPhotoManager()
	{
		return $this->container->get('acme_app.photo_manager');
	}

	protected function getSerializer(){
		$encoders = array(new JsonEncoder());
		$normalizers = array(new GetSetMethodNormalizer());
		return new Serializer($normalizers, $encoders);
	}

	public function respond($data){
		$serializer = $this->getSerializer();

		$response = new Response( $serializer->serialize($data, 'json'), 200, array('content-type' => 'application/json') );
		$response->headers->set('Access-Control-Allow-Origin', 'http://localhost:9294/');
		$response->headers->set('blavla', '*');
		return $response;
	}
}
