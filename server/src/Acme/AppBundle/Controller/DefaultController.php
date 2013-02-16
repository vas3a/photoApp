<?php

namespace Acme\AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
	public function indexAction()
	{
		return $this->render('AcmeAppBundle:Default:index.html.twig');
	}

	/** 
	*	@return PhotoManager
	*/
	protected function getPhotoManager()
	{
		return $this->container->get('acme_app.photo_manager');
	}

	public function generatePhotosAction($n = 10){
		$category = array(
			'sports',
			'abstract',
			'business',
			'cats',
			'food',
			'fashion',
			'people',
			'transport',
			'technics',
			'nature'
		);
		$counter = 0;
		foreach($category as $c){
			for($i = 1; $i <= 10; $i ++){
				if($counter <= $n){
					$photo = $this->getPhotoManager()->newPhoto();
					$photo->setTitle('test photo '.$counter.' - title');
					$photo->setSlug('test-photo-'.$counter.'-slug');
					$color = rand(0,9).rand(0,9).rand(0,9);
					// $photo->setThumbsrc('http://dummyimage.com/80x60/'.$color.'/000.jpg&text=Test+Photo+'.$i);
					// $photo->setImgsrc('http://dummyimage.com/600x400/'.$color.'/000.jpg&text=Test+Photo+'.$i);
					
					// http://lorempixel.com/800/600/sports/10/Dummy-Text/
					$photo->setThumbsrc('http://lorempixel.com/80/60/'.$c.'/'.$i.'/');
					if($counter%2 == 0)
						$photo->setImgsrc('http://lorempixel.com/600/400/'.$c.'/'.$i.'/Test-Photo-'.$counter.'/');
					else
						$photo->setImgsrc('http://lorempixel.com/600/800/'.$c.'/'.$i.'/Test-Photo-'.$counter.'/');
	
					$photo->setViews(0);
					$this->getPhotoManager()->save($photo);
					$counter++;
				}
			}
		}
		return $this->render('AcmeAppBundle:Default:index.html.twig', array('name' => $n));
	}
}
