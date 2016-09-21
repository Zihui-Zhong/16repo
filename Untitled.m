propulseurMasse = 200;
propulseurLongueur = 0.3;
propulseurRayon = 0.75;

coneArriereMasse = 800;
coneArriereLongueur = 1.5; 
coneArriereRayon = 1;

cylindreArriereMasse = 1500;
cylindreArriereLongueur = 1.5;
cylindreArriereRayon = 1;

cylindreAvantMasse = 1000;
cylindreAvantLongueur = 3;
cylindreAvantRayon = 1.5;

coneAvantMasse  = 500;
coneAvantlongueur = 1;
coneAvantRayon = 1.5;


propulseurRot = Rotz(-pi/4);
propulseurCentreMasse = [-propulseurLongueur/2,0,0]';
propulseurCentreMasse = propulseurRot*propulseurCentreMasse;

coneArriereCentreMasse = [coneArriereLongueur-coneArriereLongueur/4 0 0]';

cylindreArriereCentreMasse = [coneArriereLongueur+cylindreArriereLongueur/2 0 0]';

cylindreAvantCentreMasse = [coneArriereLongueur+cylindreArriereLongueur+cylindreAvantLongueur/2 0 0]';

coneAvantCentreMasse = [coneArriereLongueur+cylindreArriereLongueur+cylindreAvantLongueur+coneAvantlongueur/4 0 0]';

masseTotal = propulseurMasse+coneArriereMasse+cylindreArriereMasse+cylindreAvantMasse+coneAvantMasse;

centreMasseGlobal = propulseurCentreMasse*propulseurMasse;
centreMasseGlobal = centreMasseGlobal + (coneArriereMasse*coneArriereCentreMasse);
centreMasseGlobal = centreMasseGlobal + (cylindreArriereMasse*cylindreArriereCentreMasse);
centreMasseGlobal = centreMasseGlobal + (cylindreAvantMasse*cylindreAvantCentreMasse);
centreMasseGlobal = centreMasseGlobal + (coneAvantMasse*coneAvantCentreMasse);

centreMasseGlobal = centreMasseGlobal/masseTotal


propulseurInertie = InertieCylindreCreux (propulseurMasse, propulseurRayon, propulseurLongueur);
propulseurInertie = propulseurRot*(Roty(-pi/2)*propulseurInertie*Roty(-pi/2)')*propulseurRot';
propulseurInertie = momentDeplacementInertie( propulseurInertie, propulseurMasse, centreMasseGlobal, propulseurCentreMasse );

coneArrierreInertie = InertieCone(coneArriereMasse, coneArriereRayon, coneArriereLongueur);
coneArrierreInertie = Roty(-pi/2)*coneArrierreInertie*Roty(-pi/2)';
coneArrierreInertie = momentDeplacementInertie(coneArrierreInertie, coneArriereMasse, centreMasseGlobal, coneArriereCentreMasse);

cylindreArriereInertie = InertieCylindrePlein(cylindreArriereMasse, cylindreArriereRayon, cylindreArriereLongueur);
cylindreArriereInertie = Roty(-pi/2)*cylindreArriereInertie*Roty(-pi/2)';
cylindreArriereInertie = momentDeplacementInertie(cylindreArriereInertie, cylindreArriereMasse, centreMasseGlobal, cylindreArriereCentreMasse);

cylindreAvantInertie = InertieCylindreCreux(cylindreAvantMasse, cylindreAvantRayon, cylindreAvantLongueur);
cylindreAvantInertie = Roty(-pi/2)*cylindreAvantInertie*Roty(-pi/2)';
cylindreAvantInertie =  momentDeplacementInertie(cylindreAvantInertie, cylindreAvantMasse, centreMasseGlobal, cylindreAvantCentreMasse);

coneAvantInertie = InertieCone(coneAvantMasse, coneAvantRayon, coneAvantlongueur);
coneAvantInertie = Roty(pi/2)*coneAvantInertie*Roty(pi/2)';
coneAvantInertie = momentDeplacementInertie(coneAvantInertie, coneAvantMasse, centreMasseGlobal, coneAvantCentreMasse);

inertieGlobale = propulseurInertie+coneArrierreInertie+cylindreArriereInertie+cylindreAvantInertie+coneAvantInertie

force = [1000 -1000 0]';
forceLocation =[0 0 0 ]';

torque = cross ((forceLocation-centreMasseGlobal) ,force)

accelerationAngulaire = inv(inertieGlobale) * torque

vitesseAngulaire = [0 0.1 0]';
vitesseAngulaireMat = wMat(vitesseAngulaire);

test = vitesseAngulaireMat * inertieGlobale * vitesseAngulaire

accelerationAngulaireEnMouvement = inv(inertieGlobale)* (torque - vitesseAngulaireMat * inertieGlobale * vitesseAngulaire)



