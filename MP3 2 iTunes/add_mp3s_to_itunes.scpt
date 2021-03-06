FasdUAS 1.101.10   ��   ��    k             l     ��  ��    p j this script will go thru all sub folders (recursively) and look for mp3s it will add these mp3s to iTunes     � 	 	 �   t h i s   s c r i p t   w i l l   g o   t h r u   a l l   s u b   f o l d e r s   ( r e c u r s i v e l y )   a n d   l o o k   f o r   m p 3 s   i t   w i l l   a d d   t h e s e   m p 3 s   t o   i T u n e s   
  
 l     ��  ��    K E after all mp3s where added iTunes "Match" will be updated (optional)     �   �   a f t e r   a l l   m p 3 s   w h e r e   a d d e d   i T u n e s   " M a t c h "   w i l l   b e   u p d a t e d   ( o p t i o n a l )      l     ��  ��    * $ all mps3 will be deleted (optional)     �   H   a l l   m p s 3   w i l l   b e   d e l e t e d   ( o p t i o n a l )      l     ��  ��    ? 9 for every added files a growl message is send (optional)     �   r   f o r   e v e r y   a d d e d   f i l e s   a   g r o w l   m e s s a g e   i s   s e n d   ( o p t i o n a l )      l     ��  ��    L F please see propertys bellow for settings. 0 = Off / No. 1 = ON / Yes      �   �   p l e a s e   s e e   p r o p e r t y s   b e l l o w   f o r   s e t t i n g s .   0   =   O f f   /   N o .   1   =   O N   /   Y e s        l     ��   !��     � � USAGE: set this script as a folder action for a folder you want to watch or use it from the command line with: osascript add_mp3s_to_itunes.scpt <folder_to_process>    ! � " "J   U S A G E :   s e t   t h i s   s c r i p t   a s   a   f o l d e r   a c t i o n   f o r   a   f o l d e r   y o u   w a n t   t o   w a t c h   o r   u s e   i t   f r o m   t h e   c o m m a n d   l i n e   w i t h :   o s a s c r i p t   a d d _ m p 3 s _ t o _ i t u n e s . s c p t   < f o l d e r _ t o _ p r o c e s s >   # $ # l     �� % &��   % � � for use with sabnzbd create a "sabToitunes.py" python script and place it next to this file. the contense is as follows (without the leading "(*" and trailing "*)"):    & � ' 'L   f o r   u s e   w i t h   s a b n z b d   c r e a t e   a   " s a b T o i t u n e s . p y "   p y t h o n   s c r i p t   a n d   p l a c e   i t   n e x t   t o   t h i s   f i l e .   t h e   c o n t e n s e   i s   a s   f o l l o w s   ( w i t h o u t   t h e   l e a d i n g   " ( * "   a n d   t r a i l i n g   " * ) " ) : $  ( ) ( l      �� * +��   *=7
#!/usr/bin/python

import sys, os
from subprocess import call
if len(sys.argv) < 2:
    print "No folder supplied - is this being called from SABnzbd?"
    sys.exit()
else:
    scriptFile = os.path.join(os.path.dirname(sys.argv[0]), "add_mp3s_to_itunes.scpt")
    call(['osascript', scriptFile, sys.argv[1]])

    + � , ,n 
 # ! / u s r / b i n / p y t h o n 
 
 i m p o r t   s y s ,   o s 
 f r o m   s u b p r o c e s s   i m p o r t   c a l l 
 i f   l e n ( s y s . a r g v )   <   2 : 
         p r i n t   " N o   f o l d e r   s u p p l i e d   -   i s   t h i s   b e i n g   c a l l e d   f r o m   S A B n z b d ? " 
         s y s . e x i t ( ) 
 e l s e : 
         s c r i p t F i l e   =   o s . p a t h . j o i n ( o s . p a t h . d i r n a m e ( s y s . a r g v [ 0 ] ) ,   " a d d _ m p 3 s _ t o _ i t u n e s . s c p t " ) 
         c a l l ( [ ' o s a s c r i p t ' ,   s c r i p t F i l e ,   s y s . a r g v [ 1 ] ] ) 
 
 )  - . - l     �� / 0��   / R L NOTE: this script will log stuff in "~/Library/Logs/AppleScript-events.log"    0 � 1 1 �   N O T E :   t h i s   s c r i p t   w i l l   l o g   s t u f f   i n   " ~ / L i b r a r y / L o g s / A p p l e S c r i p t - e v e n t s . l o g " .  2 3 2 l     �� 4 5��   4 � � NOTE: the update_match currently only works with system language "en" or "de", because i dont know the menu names for other languages but they can be added    5 � 6 68   N O T E :   t h e   u p d a t e _ m a t c h   c u r r e n t l y   o n l y   w o r k s   w i t h   s y s t e m   l a n g u a g e   " e n "   o r   " d e " ,   b e c a u s e   i   d o n t   k n o w   t h e   m e n u   n a m e s   f o r   o t h e r   l a n g u a g e s   b u t   t h e y   c a n   b e   a d d e d 3  7 8 7 l      9 : ; 9 j     �� <�� 0 update_match   < m     ����   : ` Z should i tell to itunes update match ? this might bring itunes into front (GUI scripting)    ; � = = �   s h o u l d   i   t e l l   t o   i t u n e s   u p d a t e   m a t c h   ?   t h i s   m i g h t   b r i n g   i t u n e s   i n t o   f r o n t   ( G U I   s c r i p t i n g ) 8  > ? > l      @ A B @ j    �� C�� 0 delete_mp3s   C m    ����   A ) # should the added mp3s be deleted ?    B � D D F   s h o u l d   t h e   a d d e d   m p 3 s   b e   d e l e t e d   ? ?  E F E l      G H I G j    �� J�� (0 delay_time_seconds DELAY_TIME_SECONDS J m    ����  H 3 - How long to wait between checking file size.    I � K K Z   H o w   l o n g   t o   w a i t   b e t w e e n   c h e c k i n g   f i l e   s i z e . F  L M L j   	 �� N�� 0 myfiletypes myFiletypes N J   	  O O  P Q P m   	 
 R R � S S  . m p 3 Q  T�� T m   
  U U � V V  . m 4 a��   M  W X W l      Y Z [ Y j    �� \�� 0 enable_dialog   \ m    ����   Z  y should there be a question dialog at all? dont know why you would wan that but its kinda a leftover from the development    [ � ] ] �   s h o u l d   t h e r e   b e   a   q u e s t i o n   d i a l o g   a t   a l l ?   d o n t   k n o w   w h y   y o u   w o u l d   w a n   t h a t   b u t   i t s   k i n d a   a   l e f t o v e r   f r o m   t h e   d e v e l o p m e n t X  ^ _ ^ l      ` a b ` j    �� c�� 0 dialog_timeout   c m    ����  a c ] set the amount of time before dialogs auto-answer. it will say "no" after the amount of time    b � d d �   s e t   t h e   a m o u n t   o f   t i m e   b e f o r e   d i a l o g s   a u t o - a n s w e r .   i t   w i l l   s a y   " n o "   a f t e r   t h e   a m o u n t   o f   t i m e _  e f e l      g h i g j    �� j�� 0 test_folder   j m     k k � l l B H D D : l a d 1 3 3 7 : D e s k t o p : a d d _ m p 3 _ t e s t : h b \ process this folder if no argument is given great for testing from within the script editor    i � m m �   p r o c e s s   t h i s   f o l d e r   i f   n o   a r g u m e n t   i s   g i v e n   g r e a t   f o r   t e s t i n g   f r o m   w i t h i n   t h e   s c r i p t   e d i t o r f  n o n l      p q r p j    �� s�� 0 
more_debug   s m    ����   q   log more information    r � t t *   l o g   m o r e   i n f o r m a t i o n o  u v u j    �� w�� 0 fake   w m    ����   v  x y x j     �� z�� 0 hide_itunes   z m    ����   y  { | { l     �� } ~��   } : 4----------------- no need to edit the folowing stuff    ~ �   h - - - - - - - - - - - - - - - - -   n o   n e e d   t o   e d i t   t h e   f o l o w i n g   s t u f f |  � � � l      � � � � j   ! #�� ��� 0 
out_buffer   � m   ! " � � � � �   �  y this does not concern you !! (its an output buffer with all log messages that is returned at the end for terminal usage)    � � � � �   t h i s   d o e s   n o t   c o n c e r n   y o u   ! !   ( i t s   a n   o u t p u t   b u f f e r   w i t h   a l l   l o g   m e s s a g e s   t h a t   i s   r e t u r n e d   a t   t h e   e n d   f o r   t e r m i n a l   u s a g e ) �  � � � l      � � � � j   $ &�� ��� 0 number_of_mp3s   � m   $ %����   � 0 * counting the mp3s added to iTunes per run    � � � � T   c o u n t i n g   t h e   m p 3 s   a d d e d   t o   i T u n e s   p e r   r u n �  � � � l      � � � � j   ' +�� ��� "0 scriptgrowlname scriptGrowlName � m   ' * � � � � � 2 A d d   m p 3 s   t o   i T u n e s   s c r i p t � > 8 the name that will appear in the growl application list    � � � � p   t h e   n a m e   t h a t   w i l l   a p p e a r   i n   t h e   g r o w l   a p p l i c a t i o n   l i s t �  � � � l     �� � ���   �   logging function from    � � � � ,   l o g g i n g   f u n c t i o n   f r o m �  � � � l     �� � ���   � C = http://hints.macworld.com/article.php?story=2004121710493371    � � � � z   h t t p : / / h i n t s . m a c w o r l d . c o m / a r t i c l e . p h p ? s t o r y = 2 0 0 4 1 2 1 7 1 0 4 9 3 3 7 1 �  � � � i   , / � � � I      �� ����� 0 	log_event   �  ��� � o      ���� 0 
themessage  ��  ��   � k     - � �  � � � r      � � � b      � � � b     	 � � � l 
    ����� � l     ����� � I    �� � �
�� .sysoexecTEXT���     TEXT � l 	    ����� � m      � � � � � 4 d a t e     + ' % Y - % m - % d   % H : % M : % S '��  ��   � �� ���
�� 
rtyp � m    ��
�� 
TEXT��  ��  ��  ��  ��   � m     � � � � �    � o   	 
���� 0 
themessage   � o      ���� 0 theline theLine �  � � � l   �� � ���   � _ Y the line break in next lines "" is not a misstake. its the newline for the output buffer    � � � � �   t h e   l i n e   b r e a k   i n   n e x t   l i n e s   " "   i s   n o t   a   m i s s t a k e .   i t s   t h e   n e w l i n e   f o r   t h e   o u t p u t   b u f f e r �  � � � r     � � � b     � � � b     � � � o    ���� 0 
out_buffer   � o    ���� 0 theline theLine � m     � � � � �  
 � o      ���� 0 
out_buffer   �  � � � l   # � � � � r    # � � � l   ! ����� � n    ! � � � 1    !��
�� 
strq � o    ���� 0 theline theLine��  ��   � o      ���� 0 theline theLine �   make stuff console save    � � � � 0   m a k e   s t u f f   c o n s o l e   s a v e �  ��� � I  $ -�� ���
�� .sysoexecTEXT���     TEXT � b   $ ) � � � b   $ ' � � � m   $ % � � � � � 
 e c h o   � o   % &���� 0 theline theLine � m   ' ( � � � � � R   > >   ~ / L i b r a r y / L o g s / A p p l e S c r i p t - e v e n t s . l o g��  ��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � Q K get the system language from http://macscripter.net/viewtopic.php?id=19528    � � � � �   g e t   t h e   s y s t e m   l a n g u a g e   f r o m   h t t p : / / m a c s c r i p t e r . n e t / v i e w t o p i c . p h p ? i d = 1 9 5 2 8 �  � � � i   0 3 � � � I      �������� 0 get_sys_language  ��  ��   � k     
 � �  � � � r      � � � I    �� ���
�� .sysoexecTEXT���     TEXT � m      � � � � � � d e f a u l t s   r e a d   . G l o b a l P r e f e r e n c e s   A p p l e L a n g u a g e s   |   g r e p   - v   ' ^ ( '   |   h e a d   - n 1   |   s e d   ' s / [   , ] * / / g '��   � o      ����  0 systemlanguage SystemLanguage �  ��� � L    
 � � o    	����  0 systemlanguage SystemLanguage��   �  � � � l     ��������  ��  ��   �  � � � i   4 7 � � � I      �� ����� 0 replace_chars   �  � � � o      ���� 0 	this_text   �    o      ���� 0 search_string   �� o      ���� 0 replacement_string  ��  ��   � k        r      l    ���� o     ���� 0 search_string  ��  ��   n     	
	 1    ��
�� 
txdl
 1    ��
�� 
ascr  r     n    	 2    	��
�� 
citm o    ���� 0 	this_text   l     ���� o      ���� 0 	item_list  ��  ��    r     l   ���� o    ���� 0 replacement_string  ��  ��   n      1    ��
�� 
txdl 1    ��
�� 
ascr  r     c     l   ���� o    ���� 0 	item_list  ��  ��   m    ��
�� 
TEXT o      ���� 0 	this_text    !  r    "#" m    $$ �%%  # n     &'& 1    ��
�� 
txdl' 1    ��
�� 
ascr! (��( L     )) o    ���� 0 	this_text  ��   � *+* l     ��������  ��  ��  + ,-, l     ��./��  .   recursive process folder   / �00 2   r e c u r s i v e   p r o c e s s   f o l d e r- 121 l     ��34��  3 n h based on http://stackoverflow.com/questions/3896175/applescript-processing-files-in-folders-recursively   4 �55 �   b a s e d   o n   h t t p : / / s t a c k o v e r f l o w . c o m / q u e s t i o n s / 3 8 9 6 1 7 5 / a p p l e s c r i p t - p r o c e s s i n g - f i l e s - i n - f o l d e r s - r e c u r s i v e l y2 676 i   8 ;898 I      ��:���� 0 process_folder  : ;��; o      ���� *0 foldernametoprocess folderNameToProcess��  ��  9 k     �<< =>= Z     ?@����? =    ABA o     ���� 0 
more_debug  B m    ���� @ I   
 ��C��� 0 	log_event  C D�~D b    EFE m    GG �HH 0 n o w   l o o k i n g   i n t o   f o l d e r  F o    �}�} *0 foldernametoprocess folderNameToProcess�~  �  ��  ��  > I�|I O    �JKJ k    �LL MNM r    #OPO n    !QRQ 2    !�{
�{ 
fileR 4    �zS
�z 
cfolS o    �y�y *0 foldernametoprocess folderNameToProcessP o      �x�x 0 theitems theItemsN TUT X   $ ?V�wWV n  4 :XYX I   5 :�vZ�u�v 0 process_file  Z [�t[ o   5 6�s�s 0 thefile theFile�t  �u  Y  f   4 5�w 0 thefile theFileW o   ' (�r�r 0 theitems theItemsU \]\ r   @ J^_^ n   @ H`a` 1   F H�q
�q 
pnama n   @ Fbcb 2  D F�p
�p 
cfolc 4   @ D�od
�o 
cfold o   B C�n�n *0 foldernametoprocess folderNameToProcess_ o      �m�m 0 
thefolders 
theFolders] e�le X   K �f�kgf k   [ �hh iji s   [ aklk c   [ ^mnm o   [ \�j�j 0 	thefolder 	theFoldern m   \ ]�i
�i 
TEXTl o      �h�h 0 thefoldername TheFolderNamej opo r   b iqrq b   b gsts b   b euvu o   b c�g�g *0 foldernametoprocess folderNameToProcessv m   c dww �xx  :t o   e f�f�f 0 thefoldername TheFolderNamer o      �e�e 0 
nextfolder 
nextFolderp y�dy Q   j �z{|z n  m s}~} I   n s�c�b�c 0 process_folder   ��a� o   n o�`�` 0 
nextfolder 
nextFolder�a  �b  ~  f   m n{ R      �_��^
�_ .ascrerr ****      � ****� o      �]�] 0 errstr errStr�^  | k   { ��� ��� n  { ���� I   | ��\��[�\ 0 	log_event  � ��Z� m   | }�� ��� ( p r o c e s s _ f o l d e r   e r r o r�Z  �[  �  f   { |� ��Y� n  � ���� I   � ��X��W�X 0 	log_event  � ��V� b   � ���� m   � ��� ���  e r r o r :  � o   � ��U�U 0 errstr errStr�V  �W  �  f   � ��Y  �d  �k 0 	thefolder 	theFolderg o   N O�T�T 0 
thefolders 
theFolders�l  K m    ���                                                                                  MACS  alis    Z  SSD                        ʪ��H+  ^�;
Finder.app                                                     `�@��        ����  	                CoreServices    ʪdy      �͒    ^�;^�5^�4  -SSD:System: Library: CoreServices: Finder.app    
 F i n d e r . a p p    S S D  &System/Library/CoreServices/Finder.app  / ��  �|  7 ��� l     �S�R�Q�S  �R  �Q  � ��� l     �P���P  �   looking at a file   � ��� $   l o o k i n g   a t   a   f i l e� ��� l     �O���O  � N H basic idea from http://dougscripts.com/itunes/itinfo/folderaction01.php   � ��� �   b a s i c   i d e a   f r o m   h t t p : / / d o u g s c r i p t s . c o m / i t u n e s / i t i n f o / f o l d e r a c t i o n 0 1 . p h p� ��� l     �N���N  � H B and https://discussions.apple.com/thread/2489405?start=0&tstart=0   � ��� �   a n d   h t t p s : / / d i s c u s s i o n s . a p p l e . c o m / t h r e a d / 2 4 8 9 4 0 5 ? s t a r t = 0 & t s t a r t = 0� ��� i   < ?��� I      �M��L�M 0 process_file  � ��K� o      �J�J 
0 myfile  �K  �L  � k    C�� ��� l    ���� r     ��� l    ��I�H� c     ��� o     �G�G 
0 myfile  � m    �F
�F 
alis�I  �H  � o      �E�E 0 f  � 2 , i dont know what this does / why its needed   � ��� X   i   d o n t   k n o w   w h a t   t h i s   d o e s   /   w h y   i t s   n e e d e d� ��� l   �D�C�B�D  �C  �B  � ��� r    ��� l   ��A�@� n    ��� 1   	 �?
�? 
strq� l   	��>�=� n    	��� 1    	�<
�< 
psxp� o    �;�; 0 f  �>  �=  �A  �@  � l     ��:�9� o      �8�8 0 	file_path  �:  �9  � ��� l   �7���7  � Z T the POSIX path because logging "f" does not work / crashes when the files has a ->'   � ��� �   t h e   P O S I X   p a t h   b e c a u s e   l o g g i n g   " f "   d o e s   n o t   w o r k   /   c r a s h e s   w h e n   t h e   f i l e s   h a s   a   - > '� ��� Z    $���6�5� =   ��� o    �4�4 0 
more_debug  � m    �3�3 � I     �2��1�2 0 	log_event  � ��0� b    ��� m    �� ���   l o o k i n g   a t   f i l e  � o    �/�/ 0 	file_path  �0  �1  �6  �5  � ��� O  % 3��� r   ) 2��� c   ) 0��� b   ) .��� m   ) *�� ���  .� l  * -��.�-� n   * -��� 1   + -�,
�, 
nmxt� o   * +�+�+ 0 f  �.  �-  � m   . /�*
�* 
TEXT� o      �)�) "0 myitemextension myItemExtension� m   % &���                                                                                  MACS  alis    Z  SSD                        ʪ��H+  ^�;
Finder.app                                                     `�@��        ����  	                CoreServices    ʪdy      �͒    ^�;^�5^�4  -SSD:System: Library: CoreServices: Finder.app    
 F i n d e r . a p p    S S D  &System/Library/CoreServices/Finder.app  / ��  � ��� l  4 4�(���(  �   do we have a mp3 file ?   � ��� 0   d o   w e   h a v e   a   m p 3   f i l e   ?� ��'� Z   4C���&�� E   4 ;��� o   4 9�%�% 0 myfiletypes myFiletypes� o   9 :�$�$ "0 myitemextension myItemExtension� k   >*�� ��� l  > >�#���#  � v p it will check if the file that was added is still beeing copied by checking the size every <DELAY_TIME_SECONDS>   � ��� �   i t   w i l l   c h e c k   i f   t h e   f i l e   t h a t   w a s   a d d e d   i s   s t i l l   b e e i n g   c o p i e d   b y   c h e c k i n g   t h e   s i z e   e v e r y   < D E L A Y _ T I M E _ S E C O N D S >� ��� r   > A��� m   > ?�"�"  � o      �!�! 0 oldsize oldSize� ��� r   B E��� m   B C� � ��� o      �� 0 newsize newSize� � � l  F F��   b \ When newSize equals oldSize, it means the copy is complete because the size hasn't changed.    � �   W h e n   n e w S i z e   e q u a l s   o l d S i z e ,   i t   m e a n s   t h e   c o p y   i s   c o m p l e t e   b e c a u s e   t h e   s i z e   h a s n ' t   c h a n g e d .   V   F � k   N � 	
	 Z   N b�� =  N U o   N S�� 0 
more_debug   m   S T��  I   X ^��� 0 	log_event   � m   Y Z � ( l o o k i n g   a t   f i l e   s i z e�  �  �  �  
  l  c c��     Get the file size.    � &   G e t   t h e   f i l e   s i z e .  r   c l n   c j 1   h j�
� 
ptsz l  c h�� I  c h��
� .sysonfo4asfe        file o   c d�� 0 f  �  �  �   o      �� 0 oldsize oldSize  !  I  m v�"�
� .sysodelanull��� ��� nmbr" o   m r�� (0 delay_time_seconds DELAY_TIME_SECONDS�  ! #$# l  w w�%&�  % 8 2 Sample the size again after delay for comparison.   & �'' d   S a m p l e   t h e   s i z e   a g a i n   a f t e r   d e l a y   f o r   c o m p a r i s o n .$ (�
( r   w �)*) n   w ~+,+ 1   | ~�	
�	 
ptsz, l  w |-��- I  w |�.�
� .sysonfo4asfe        file. o   w x�� 0 f  �  �  �  * o      �� 0 newsize newSize�
   >  J M/0/ o   J K�� 0 newsize newSize0 o   K L�� 0 oldsize oldSize 121 Z   � �34� ��3 =  � �565 o   � ����� 0 
more_debug  6 m   � ����� 4 I   � ���7���� 0 	log_event  7 8��8 m   � �99 �:: 2 d o n e   l o o k i n g   a t   f i l e   s i z e��  ��  �   ��  2 ;<; l  � ���������  ��  ��  < =>= r   � �?@? m   � �AA �BB  Y e s@ l     C����C o      ���� 0 user_choice  ��  ��  > D��D Z   �*EF����E =  � �GHG o   � ����� 0 user_choice  H m   � �II �JJ  Y e sF k   �&KK LML l  � ���NO��  N , & HERE BEGINS THE ITUNES SPECIFIC STUFF   O �PP L   H E R E   B E G I N S   T H E   I T U N E S   S P E C I F I C   S T U F FM QRQ I   � ���S���� 0 	log_event  S T��T b   � �UVU m   � �WW �XX . a d d i n g   f i l e   t o   i t u n e s :  V o   � ����� 0 	file_path  ��  ��  R YZY Q   �$[\][ k   �^^ _`_ Z   � �ab����a =  � �cdc o   � ����� 0 fake  d m   � �����  b O   � �efe k   � �gg hih I  � �������
�� .ascrnoop****      � ****��  ��  i j��j I  � ���k��
�� .hookAdd cTrk      @ alisk o   � ����� 0 f  ��  ��  f m   � �ll�                                                                                  hook  alis    2  SSD                        ʪ��H+  ^�X
iTunes.app                                                     b[Q��'�        ����  	                Applications    ʪdy      ��r    ^�X  SSD:Applications: iTunes.app   
 i T u n e s . a p p    S S D  Applications/iTunes.app   / ��  ��  ��  ` mnm r   � �opo [   � �qrq o   � ����� 0 number_of_mp3s  r m   � ����� p o      ���� 0 number_of_mp3s  n s��s Z   �tu����t =  � �vwv o   � ����� 0 fake  w m   � �����  u Z   �xy����x =  � �z{z o   � ����� 0 delete_mp3s  { m   � ����� y I  � ���|��
�� .sysoexecTEXT���     TEXT| l  � �}����} b   � �~~ m   � ��� ���  r m   - f   o   � ����� 0 	file_path  ��  ��  ��  ��  ��  ��  ��  ��  \ R      �����
�� .ascrerr ****      � ****� o      ���� 0 errstr errStr��  ] k  $�� ��� I  ������� 0 	log_event  � ���� b  ��� m  �� ��� : e r r o r   a d d i n g   f i l e   t o   i t u n e s :  � o  ���� 0 	file_path  ��  ��  � ���� I  $������� 0 	log_event  � ���� b   ��� m  �� ���  e r r o r :  � o  ���� 0 errstr errStr��  ��  ��  Z ���� l %%������  � * $ HERE ENDS THE ITUNES SPECIFIC STUFF   � ��� H   H E R E   E N D S   T H E   I T U N E S   S P E C I F I C   S T U F F��  ��  ��  ��  �&  � Z  -C������� = -4��� o  -2���� 0 
more_debug  � m  23���� � I  7?������� 0 	log_event  � ���� m  8;�� ���  n o t   a n   m p 3��  ��  ��  ��  �'  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  �   main stuff   � ���    m a i n   s t u f f� ��� i   @ C��� I      ������� 0 main  � ���� o      ���� 0 root  ��  ��  � k     ��� ��� l     ��������  ��  ��  � ��� I     ������� 0 	log_event  � ���� m    �� ��� 8 r u n n i n g   m p 3   t o   i T u n e s   s c r i p t��  ��  � ��� r    ��� m    ����  � o      ���� 0 number_of_mp3s  � ��� l   ������  � 9 3 this will look at all files and folder recursively   � ��� f   t h i s   w i l l   l o o k   a t   a l l   f i l e s   a n d   f o l d e r   r e c u r s i v e l y� ��� I    ������� 0 process_folder  � ���� o    ���� 0 root  ��  ��  � ��� l   ��������  ��  ��  � ��� Z    �������� =   ��� o    ���� 0 update_match  � m    ���� � Q     ������ k   # ��� ��� I   # )������� 0 	log_event  � ���� m   $ %�� ��� < t e l l i n g   i t u n e s   t o   u p d a t e   m a t c h��  ��  � ��� l  * *������  � %  en and default menu item names   � ��� >   e n   a n d   d e f a u l t   m e n u   i t e m   n a m e s� ��� r   * -��� m   * +�� ��� & U p d a t e   i T u n e s   M a t c h� o      ���� 0 match_menu_item  � ��� r   . 1��� m   . /�� ��� 
 S t o r e� o      ���� 0 store_menu_item  � ��� l  2 2������  �   get system language   � ��� (   g e t   s y s t e m   l a n g u a g e� ��� r   2 9��� I   2 7�������� 0 get_sys_language  ��  ��  � o      ���� 0 cur_lang  � ��� l  : :������  � &   feel free to add more languages   � ��� @   f e e l   f r e e   t o   a d d   m o r e   l a n g u a g e s� ��� Z   : K������� =  : =��� o   : ;���� 0 cur_lang  � m   ; <�� ���  d e� k   @ G�� ��� r   @ C� � m   @ A � 4 i T u n e s   M a t c h   a k t u a l i s i e r e n  o      ���� 0 match_menu_item  � �� r   D G m   D E � 
 S t o r e o      ���� 0 store_menu_item  ��  ��  ��  � 	 O  L V

 I  P U������
�� .miscactvnull��� ��� null��  ��   m   L M�                                                                                  hook  alis    2  SSD                        ʪ��H+  ^�X
iTunes.app                                                     b[Q��'�        ����  	                Applications    ʪdy      ��r    ^�X  SSD:Applications: iTunes.app   
 i T u n e s . a p p    S S D  Applications/iTunes.app   / ��  	  O   W { O   [ z I  b y����
�� .prcsclicuiel    ��� uiel n   b u 4   p u��
�� 
menI o   s t���� 0 match_menu_item   n   b p 4   k p��
�� 
menE m   n o��  n   b k 4   f k�~
�~ 
mbri o   i j�}�} 0 store_menu_item   4   b f�|
�| 
mbar m   d e�{�{ ��   4   [ _�z
�z 
pcap m   ] ^ �    i T u n e s m   W X!!�                                                                                  sevs  alis    v  SSD                        ʪ��H+  ^�;System Events.app                                              a�n��        ����  	                CoreServices    ʪdy      ���    ^�;^�5^�4  4SSD:System: Library: CoreServices: System Events.app  $  S y s t e m   E v e n t s . a p p    S S D  -System/Library/CoreServices/System Events.app   / ��   "�y" Z   | �#$�x�w# =  | �%&% o   | ��v�v 0 hide_itunes  & m   � ��u�u $ O   � �'(' r   � �)*) m   � ��t
�t boovfals* n      +,+ 1   � ��s
�s 
pvis, 4   � ��r-
�r 
prcs- m   � �.. �//  i T u n e s( m   � �00�                                                                                  sevs  alis    v  SSD                        ʪ��H+  ^�;System Events.app                                              a�n��        ����  	                CoreServices    ʪdy      ���    ^�;^�5^�4  4SSD:System: Library: CoreServices: System Events.app  $  S y s t e m   E v e n t s . a p p    S S D  -System/Library/CoreServices/System Events.app   / ��  �x  �w  �y  � R      �q�p�o
�q .ascrerr ****      � ****�p  �o  ��  ��  ��  � 1�n1 I   � ��m2�l�m 0 	log_event  2 3�k3 b   � �454 o   � ��j�j "0 scriptgrowlname scriptGrowlName5 m   � �66 �77 
   d o n e�k  �l  �n  � 898 l     �i�h�g�i  �h  �g  9 :;: l     �f<=�f  < U O the run method. it is called when run with osascript or from the script editor   = �>> �   t h e   r u n   m e t h o d .   i t   i s   c a l l e d   w h e n   r u n   w i t h   o s a s c r i p t   o r   f r o m   t h e   s c r i p t   e d i t o r; ?@? i   D GABA I     �eC�d
�e .aevtoappnull  �   � ****C o      �c�c 0 argv  �d  B k     sDD EFE r     GHG m     II �JJ  H o      �b�b 0 
out_buffer  F KLK Z    lMN�aOM ?    PQP l   R�`�_R I   �^S�]
�^ .corecnte****       ****S o    	�\�\ 0 argv  �]  �`  �_  Q m    �[�[  N k    _TT UVU r    WXW n    YZY 4    �Z[
�Z 
cobj[ m    �Y�Y Z o    �X�X 0 argv  X o      �W�W 0 pathtoprocess pathToProcessV \]\ I    !�V^�U�V 0 	log_event  ^ _�T_ b    `a` m    bb �cc , c a l l e d   w i t h   a r g u m e n t :  a o    �S�S 0 pathtoprocess pathToProcess�T  �U  ] ded r   " .fgf c   " (hih n   " &jkj 4   # &�Rl
�R 
cobjl m   $ %�Q�Q k o   " #�P�P 0 argv  i m   & '�O
�O 
longg o      �N�N 0 delete_mp3s  e mnm r   / ;opo c   / 5qrq n   / 3sts 4   0 3�Mu
�M 
cobju m   1 2�L�L t o   / 0�K�K 0 argv  r m   3 4�J
�J 
longp o      �I�I 0 update_match  n vwv r   < Hxyx c   < Bz{z n   < @|}| 4   = @�H~
�H 
cobj~ m   > ?�G�G } o   < =�F�F 0 argv  { m   @ A�E
�E 
longy o      �D�D 0 hide_itunes  w � r   I Q��� c   I O��� 4   I M�C�
�C 
psxf� o   K L�B�B 0 pathtoprocess pathToProcess� m   M N�A
�A 
TEXT� o      �@�@ 0 pathtoprocess pathToProcess� ��� I   R X�?��>�? 0 	log_event  � ��=� m   S T�� ��� * s t a r t n g   m a i n   f u n c t i o n�=  �>  � ��<� I   Y _�;��:�; 0 main  � ��9� o   Z [�8�8 0 pathtoprocess pathToProcess�9  �:  �<  �a  O k   b l�� ��� l  b b�7���7  �   test function   � ���    t e s t   f u n c t i o n� ��6� I   b l�5��4�5 0 main  � ��3� o   c h�2�2 0 test_folder  �3  �4  �6  L ��1� L   m s�� o   m r�0�0 0 
out_buffer  �1  @ ��/� l     �.�-�,�.  �-  �,  �/       *�+��*�)�(��'�& k�%�$�#��" ����������!� ������������������+  � (�����
�	��������� ��������������������������������������������������� 0 update_match  � 0 delete_mp3s  � (0 delay_time_seconds DELAY_TIME_SECONDS� 0 myfiletypes myFiletypes�
 0 enable_dialog  �	 0 dialog_timeout  � 0 test_folder  � 0 
more_debug  � 0 fake  � 0 hide_itunes  � 0 
out_buffer  � 0 number_of_mp3s  � "0 scriptgrowlname scriptGrowlName� 0 	log_event  �  0 get_sys_language  �� 0 replace_chars  �� 0 process_folder  �� 0 process_file  �� 0 main  
�� .aevtoappnull  �   � ****�� 0 pathtoprocess pathToProcess��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  �*  �) �( � ����� �   R U�'  �& �%  �$  �#  � ��� 2 0 1 3 - 0 5 - 1 1   1 9 : 3 8 : 4 1   c a l l e d   w i t h   a r g u m e n t :   / V o l u m e s / H D D / l a d 1 3 3 7 / A z u r e u s / s a b n z b d / T h e   W a y   O f   A l l   F l e s h   ( X D M . 1 1 1 6 7 - 2 2 2 ) 
 2 0 1 3 - 0 5 - 1 1   1 9 : 3 8 : 4 1   s t a r t n g   m a i n   f u n c t i o n 
 2 0 1 3 - 0 5 - 1 1   1 9 : 3 8 : 4 1   r u n n i n g   m p 3   t o   i T u n e s   s c r i p t 
 2 0 1 3 - 0 5 - 1 1   1 9 : 3 8 : 4 5   a d d i n g   f i l e   t o   i t u n e s :   ' / V o l u m e s / H D D / l a d 1 3 3 7 / A z u r e u s / s a b n z b d / T h e   W a y   O f   A l l   F l e s h   ( X D M . 1 1 1 6 7 - 2 2 2 ) / 0 1 - g o j i r a - o r o b o r u s . m p 3 ' 
 2 0 1 3 - 0 5 - 1 1   1 9 : 3 8 : 5 5   a d d i n g   f i l e   t o   i t u n e s :   ' / V o l u m e s / H D D / l a d 1 3 3 7 / A z u r e u s / s a b n z b d / T h e   W a y   O f   A l l   F l e s h   ( X D M . 1 1 1 6 7 - 2 2 2 ) / 0 2 - g o j i r a - t o x i c _ g a r b a g e _ i s l a n d . m p 3 ' 
 2 0 1 3 - 0 5 - 1 1   1 9 : 3 9 : 0 0   a d d i n g   f i l e   t o   i t u n e s :   ' / V o l u m e s / H D D / l a d 1 3 3 7 / A z u r e u s / s a b n z b d / T h e   W a y   O f   A l l   F l e s h   ( X D M . 1 1 1 6 7 - 2 2 2 ) / 0 3 - g o j i r a - a _ s i g h t _ t o _ b e h o l d . m p 3 ' 
 2 0 1 3 - 0 5 - 1 1   1 9 : 3 9 : 0 6   a d d i n g   f i l e   t o   i t u n e s :   ' / V o l u m e s / H D D / l a d 1 3 3 7 / A z u r e u s / s a b n z b d / T h e   W a y   O f   A l l   F l e s h   ( X D M . 1 1 1 6 7 - 2 2 2 ) / 0 4 - g o j i r a - y a m a s _ m e s s e n g e r s . m p 3 ' 
 2 0 1 3 - 0 5 - 1 1   1 9 : 3 9 : 1 2   a d d i n g   f i l e   t o   i t u n e s :   ' / V o l u m e s / H D D / l a d 1 3 3 7 / A z u r e u s / s a b n z b d / T h e   W a y   O f   A l l   F l e s h   ( X D M . 1 1 1 6 7 - 2 2 2 ) / 0 5 - g o j i r a - t h e _ s i l v e r _ c o r d . m p 3 ' 
 2 0 1 3 - 0 5 - 1 1   1 9 : 3 9 : 1 9   a d d i n g   f i l e   t o   i t u n e s :   ' / V o l u m e s / H D D / l a d 1 3 3 7 / A z u r e u s / s a b n z b d / T h e   W a y   O f   A l l   F l e s h   ( X D M . 1 1 1 6 7 - 2 2 2 ) / 0 6 - g o j i r a - a l l _ t h e _ t e a r s . m p 3 ' 
 2 0 1 3 - 0 5 - 1 1   1 9 : 3 9 : 2 5   a d d i n g   f i l e   t o   i t u n e s :   ' / V o l u m e s / H D D / l a d 1 3 3 7 / A z u r e u s / s a b n z b d / T h e   W a y   O f   A l l   F l e s h   ( X D M . 1 1 1 6 7 - 2 2 2 ) / 0 7 - g o j i r a - a d o r a t i o n _ f o r _ n o n e . m p 3 ' 
 2 0 1 3 - 0 5 - 1 1   1 9 : 3 9 : 3 1   a d d i n g   f i l e   t o   i t u n e s :   ' / V o l u m e s / H D D / l a d 1 3 3 7 / A z u r e u s / s a b n z b d / T h e   W a y   O f   A l l   F l e s h   ( X D M . 1 1 1 6 7 - 2 2 2 ) / 0 8 - g o j i r a - t h e _ a r t _ o f _ d y i n g . m p 3 ' 
 2 0 1 3 - 0 5 - 1 1   1 9 : 3 9 : 3 7   a d d i n g   f i l e   t o   i t u n e s :   ' / V o l u m e s / H D D / l a d 1 3 3 7 / A z u r e u s / s a b n z b d / T h e   W a y   O f   A l l   F l e s h   ( X D M . 1 1 1 6 7 - 2 2 2 ) / 0 9 - g o j i r a - e s o t e r i c _ s u r g e r y . m p 3 ' 
 2 0 1 3 - 0 5 - 1 1   1 9 : 3 9 : 4 3   a d d i n g   f i l e   t o   i t u n e s :   ' / V o l u m e s / H D D / l a d 1 3 3 7 / A z u r e u s / s a b n z b d / T h e   W a y   O f   A l l   F l e s h   ( X D M . 1 1 1 6 7 - 2 2 2 ) / 1 0 - g o j i r a - v a c u i t y . m p 3 ' 
 2 0 1 3 - 0 5 - 1 1   1 9 : 3 9 : 4 9   a d d i n g   f i l e   t o   i t u n e s :   ' / V o l u m e s / H D D / l a d 1 3 3 7 / A z u r e u s / s a b n z b d / T h e   W a y   O f   A l l   F l e s h   ( X D M . 1 1 1 6 7 - 2 2 2 ) / 1 1 - g o j i r a - w o l f _ d o w n _ t h e _ e a r t h . m p 3 ' 
 2 0 1 3 - 0 5 - 1 1   1 9 : 3 9 : 5 4   a d d i n g   f i l e   t o   i t u n e s :   ' / V o l u m e s / H D D / l a d 1 3 3 7 / A z u r e u s / s a b n z b d / T h e   W a y   O f   A l l   F l e s h   ( X D M . 1 1 1 6 7 - 2 2 2 ) / 1 2 - g o j i r a - t h e _ w a y _ o f _ a l l _ f l e s h . m p 3 ' 
 2 0 1 3 - 0 5 - 1 1   1 9 : 3 9 : 5 7   A d d   m p 3 s   t o   i T u n e s   s c r i p t   d o n e 
�" � �� ����������� 0 	log_event  �� ����� �  ���� 0 
themessage  ��  � ������ 0 
themessage  �� 0 theline theLine� 	 ������� � ��� � �
�� 
rtyp
�� 
TEXT
�� .sysoexecTEXT���     TEXT
�� 
strq�� .���l �%�%E�Ob  
�%�%Ec  
O��,E�O�%�%j � �� ����������� 0 get_sys_language  ��  ��  � ����  0 systemlanguage SystemLanguage�  ���
�� .sysoexecTEXT���     TEXT�� �j E�O�� �� ����������� 0 replace_chars  �� ����� �  �������� 0 	this_text  �� 0 search_string  �� 0 replacement_string  ��  � ���������� 0 	this_text  �� 0 search_string  �� 0 replacement_string  �� 0 	item_list  � ��������$
�� 
ascr
�� 
txdl
�� 
citm
�� 
TEXT�� !���,FO��-E�O���,FO��&E�O���,FO�� ��9���������� 0 process_folder  �� ����� �  ���� *0 foldernametoprocess folderNameToProcess��  � ������������������ *0 foldernametoprocess folderNameToProcess�� 0 theitems theItems�� 0 thefile theFile�� 0 
thefolders 
theFolders�� 0 	thefolder 	theFolder�� 0 thefoldername TheFolderName�� 0 
nextfolder 
nextFolder�� 0 errstr errStr� G�������������������w���������� 0 	log_event  
�� 
cfol
�� 
file
�� 
kocl
�� 
cobj
�� .corecnte****       ****�� 0 process_file  
�� 
pnam
�� 
TEXT�� 0 process_folder  �� 0 errstr errStr��  �� �b  k  *�%k+ Y hO� x*�/�-E�O �[��l kh )�k+ [OY��O*�/�-�,E�O E�[��l kh ��&EQ�O��%�%E�O )�k+ W X  )�k+ O)a �%k+ [OY��U� ������������� 0 process_file  �� ����� �  ���� 
0 myfile  ��  � ������������������ 
0 myfile  �� 0 f  �� 0 	file_path  �� "0 myitemextension myItemExtension�� 0 oldsize oldSize�� 0 newsize newSize�� 0 user_choice  �� 0 errstr errStr� ���������������������9AIWl��������������
�� 
alis
�� 
psxp
�� 
strq�� 0 	log_event  
�� 
nmxt
�� 
TEXT
�� .sysonfo4asfe        file
�� 
ptsz
�� .sysodelanull��� ��� nmbr
�� .ascrnoop****      � ****
�� .hookAdd cTrk      @ alis
�� .sysoexecTEXT���     TEXT�� 0 errstr errStr��  ��D��&E�O��,�,E�Ob  k  *�%k+ Y hO� ��,%�&E�UOb  � �jE�OiE�O >h��b  k  *�k+ Y hO�j 
�,E�Ob  j O�j 
�,E�[OY��Ob  k  *�k+ Y hO�E�O��  �*a �%k+ O Yb  j  a  *j O�j UY hOb  kEc  Ob  j  b  k  a �%j Y hY hW X  *a �%k+ O*a �%k+ OPY hY b  k  *a k+ Y h� ������������� 0 main  �� ����� �  ���� 0 root  ��  � ���������� 0 root  �� 0 match_menu_item  �� 0 store_menu_item  �� 0 cur_lang  � �������������!��~�}�|�{�z�y.�x�w�v6�� 0 	log_event  �� 0 process_folder  �� 0 get_sys_language  
�� .miscactvnull��� ��� null
� 
pcap
�~ 
mbar
�} 
mbri
�| 
menE
�{ 
menI
�z .prcsclicuiel    ��� uiel
�y 
prcs
�x 
pvis�w  �v  �� �*�k+ OjEc  O*�k+ Ob   k  � *�k+ O�E�O�E�O*j+ E�O��  �E�O�E�Y hO� *j UO� !*��/ *�k/a �/a k/a �/j UUOb  	k  � f*a a /a ,FUY hW X  hY hO*b  a %k+ � �uB�t�s���r
�u .aevtoappnull  �   � ****�t 0 argv  �s  � �q�q 0 argv  � I�p�o�nb�m�l�k�j�i��h
�p .corecnte****       ****
�o 
cobj�n 0 pathtoprocess pathToProcess�m 0 	log_event  
�l 
long�k 
�j 
psxf
�i 
TEXT�h 0 main  �r t�Ec  
O�j j R��k/E�O*��%k+ O��l/�&Ec  O��m/�&Ec   O���/�&Ec  	O*��/�&E�O*�k+ O*�k+ Y *b  k+ Ob  
� ��� � H D D : l a d 1 3 3 7 : A z u r e u s : s a b n z b d : T h e   W a y   O f   A l l   F l e s h   ( X D M . 1 1 1 6 7 - 2 2 2 )�!  �   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  ascr  ��ޭ